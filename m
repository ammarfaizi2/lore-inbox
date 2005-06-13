Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVFMWrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVFMWrb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 18:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVFMWq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 18:46:27 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:5 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261615AbVFMWm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 18:42:57 -0400
Date: Mon, 13 Jun 2005 15:43:30 -0700
To: "Saksena, Manas" <Manas.Saksena@timesys.com>
Cc: karim@opersys.com, dwalker@mvista.com, paulmck@us.ibm.com,
       Andrea Arcangeli <andrea@suse.de>, Bill Huey <bhuey@lnxw.com>,
       Lee Revell <rlrevell@joe-job.com>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, hch@infradead.org, akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050613224330.GA1113@nietzsche.lynx.com>
References: <3D848382FB72E249812901444C6BDB1D01588198@exchange.timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D848382FB72E249812901444C6BDB1D01588198@exchange.timesys.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 06:20:10PM -0400, Saksena, Manas wrote:
> Keep in mind that Linux has been making inroads into traditional
> RTOS markets for 4+ years. RTOSes have been used in many devices
> and systems -- many of which do not need the "ruby/diamond" hard
> variety of real-time -- preempt-rt would be hard-enough for a 
> very large number of devices/systems that currently use an RTOS
> (or non mainline Linux kernel). 

It's better to use different terminology. The notion of real time
is *not* a single dimensional vector that is either "more" or "less"
than of any particular thing. It's much more complicated than that.

There's at least more than one definition of hard real time floating
around with various degrees of determinism. Deterministic is
deterministic and many RTOS are capable of that. Theoretically provable
anything is pushing it and is not RTOSes are typically constructed.

I recommend dropping that ridiculous terminology because how complex
this problem/domain is as well as how misleading it can be.

bill

