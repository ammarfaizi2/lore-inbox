Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUAFUuX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 15:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUAFUuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 15:50:23 -0500
Received: from APastourelles-108-2-1-3.w80-14.abo.wanadoo.fr ([80.14.139.3]:7040
	"EHLO mail.two-towers.net") by vger.kernel.org with ESMTP
	id S265211AbUAFUuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 15:50:21 -0500
Message-ID: <3FFB1F83.4030300@two-towers.net>
Date: Tue, 06 Jan 2004 21:50:11 +0100
From: Philip Dodd <spambox@two-towers.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: greg@enjellic.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.24 and exec-shield-2.4.23-G4
References: <200401060747.i067lr5S030638@wind.enjellic.com>
In-Reply-To: <200401060747.i067lr5S030638@wind.enjellic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dr. Greg Wettstein wrote:
8<
> 
> The preliminary indications I have indicate there are problems.
> 
> I applied the 2.4.23-G4 patch from Ingo with the same results you had,
> ie the the mmremap offset and Makefile failures.  Compiled and
> rebooted the kernel on a test machine.
> 
> XFree86 4.3.0 with the RedHat patches now fails to start with a SIG11
> error.  Turning off exec-shield (echoing 0 to
> /proc/sys/kernel/exec-shield) enables XFree to start normally.
> 
> So it would seem that something changed with the mremap changes in
> 2.4.24.
8<

Just out of interest, were you running the same config (boot params 
etc.) before moving to 2.4.24?

Have you looked at this page: 
http://people.redhat.com/mingo/exec-shield/ANNOUNCE-exec-shield

In particular the X workaround option.  I believe there are known issues 
with some versions of X and this patch, but the box I use it on isn't 
running X, so I use exec-shield=3 and have had no problems with the 
2.4.23-G4 patch on 2.4.24..... yet :-)

Thanks for the reply,

Phil


-- 
()  ascii ribbon campaign - against html mail
/\                        - against microsoft attachments

