Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVFMUiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVFMUiR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 16:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVFMUec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 16:34:32 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:2576 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261322AbVFMUcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:32:39 -0400
Date: Mon, 13 Jun 2005 13:38:06 -0700
To: Daniel Walker <dwalker@mvista.com>
Cc: karim@opersys.com, paulmck@us.ibm.com, Andrea Arcangeli <andrea@suse.de>,
       Bill Huey <bhuey@lnxw.com>, Lee Revell <rlrevell@joe-job.com>,
       Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, hch@infradead.org, akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050613203806.GB32690@nietzsche.lynx.com>
References: <20050610232955.GH6564@g5.random> <20050611014133.GO1300@us.ibm.com> <20050611155459.GB5796@g5.random> <20050611210417.GC1299@us.ibm.com> <42AB7857.1090907@opersys.com> <20050612214519.GB1340@us.ibm.com> <42ACE2D3.9080106@opersys.com> <20050613144022.GA1305@us.ibm.com> <42ADE334.4030002@opersys.com> <1118693033.2725.21.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118693033.2725.21.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 01:03:53PM -0700, Daniel Walker wrote:
> On Mon, 2005-06-13 at 15:49 -0400, Karim Yaghmour wrote:
> >...
> > What I'm suggesting is that rt patches shouldn't touch the existing
> > codebase. Instead, functionality having to do with rt should be
> > integrated in separate directories, and depending the way you
> > configure the kernel, include/linux would point to either
> > include/linux-srt or include/linux-hrt, much like include/asm
> > points to one of inclux/asm-*.
> 
> I think this is mistake. Projects that create separation like this are
> begging for the community to reject them. I see this as a design for
> one, instead of design for many mistake. From what I've seen, a project
> would want to do as much clean integration as possible.

The problem with the patch at this time is that many of the headers,
including the one you mention, need clean up as well as some
reorganization. The problem with general sloppiness of the patch from
rapid patch inclusion is different than the big event of integrating
the patch into the mainline. Also, folks like me and you in our
respective companies are much more aggressive about doing things with
the patch which is the exception of Linux kernel users and not the
norm. A little more testing wouldn't hurt as well, but I think the
patch is certainly worth getting into an semi-experimental kernel.

IMO, the patch should go eventually, but after some significant clean
up. There will be other areas in the kernel that will force some
more proper abstraction and compartmentalization.

That's my view on the matter.

bill

