Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263010AbUCXHg3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 02:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbUCXHg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 02:36:29 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:40446 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S263010AbUCXHfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 02:35:37 -0500
Date: Wed, 24 Mar 2004 15:31:25 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: ncunningham@users.sourceforge.net
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Cc: "Dmitry Torokhov" <dtor_core@ameritech.net>,
       "Pavel Machek" <pavel@suse.cz>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Swsusp mailing list" <swsusp-devel@lists.sourceforge.net>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au>  <200403231743.01642.dtor_core@ameritech.net>  <20040323233228.GK364@elf.ucw.cz>  <200403232352.58066.dtor_core@ameritech.net>  <1080104698.3014.4.camel@calvin.wpcb.org.au>  <opr5cry20s4evsfm@smtp.pacific.net.th> <1080107188.2205.10.camel@laptop-linux.wpcb.org.au>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr5cu6ngl4evsfm@smtp.pacific.net.th>
In-Reply-To: <1080107188.2205.10.camel@laptop-linux.wpcb.org.au>
User-Agent: Opera M2/7.50 (Linux, build 615)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2004 17:46:28 +1200, Nigel Cunningham <ncunningham@users.sourceforge.net> wrote:

> Hi.
>
> On Wed, 2004-03-24 at 18:22, Michael Frank wrote:
>> Error messages should be handled on a seperate VT eliminating the issue.
>
> While I definitely like the idea, I'm not sure that's feasible; as Pavel
> pointed out, Suspend doesn't generate all the error messages that might
> possibly appear. Maybe I'm just ignorant.. I'll take a look when I get
> the change.

printk is central and could do the switch when swsusp is active

