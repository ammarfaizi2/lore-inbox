Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVFMUFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVFMUFd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 16:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVFMUFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 16:05:32 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:753 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261234AbVFMUET
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:04:19 -0400
Subject: Re: Attempted summary of "RT patch acceptance" thread
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: karim@opersys.com
Cc: paulmck@us.ibm.com, Andrea Arcangeli <andrea@suse.de>,
       Bill Huey <bhuey@lnxw.com>, Lee Revell <rlrevell@joe-job.com>,
       Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, hch@infradead.org, akpm@osdl.org
In-Reply-To: <42ADE334.4030002@opersys.com>
References: <20050610223724.GA20853@nietzsche.lynx.com>
	 <20050610225231.GF6564@g5.random>
	 <20050610230836.GD21618@nietzsche.lynx.com>
	 <20050610232955.GH6564@g5.random> <20050611014133.GO1300@us.ibm.com>
	 <20050611155459.GB5796@g5.random> <20050611210417.GC1299@us.ibm.com>
	 <42AB7857.1090907@opersys.com> <20050612214519.GB1340@us.ibm.com>
	 <42ACE2D3.9080106@opersys.com> <20050613144022.GA1305@us.ibm.com>
	 <42ADE334.4030002@opersys.com>
Content-Type: text/plain
Organization: MontaVista
Date: Mon, 13 Jun 2005 13:03:53 -0700
Message-Id: <1118693033.2725.21.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 15:49 -0400, Karim Yaghmour wrote:
> Paul E. McKenney wrote:
> > OK...  Then the idea is to dynamically redirect the symbolic link
> > to include/linux-srt or include/linux-srt that you mentioned in your
> > previous email, or is the symlink serving some other purpose?
> 
> What I'm suggesting is that rt patches shouldn't touch the existing
> codebase. Instead, functionality having to do with rt should be
> integrated in separate directories, and depending the way you
> configure the kernel, include/linux would point to either
> include/linux-srt or include/linux-hrt, much like include/asm
> points to one of inclux/asm-*.


I think this is mistake. Projects that create separation like this are
begging for the community to reject them. I see this as a design for
one, instead of design for many mistake. From what I've seen, a project
would want to do as much clean integration as possible.

Daniel

