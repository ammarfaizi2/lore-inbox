Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbULUQYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbULUQYG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 11:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbULUQXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 11:23:45 -0500
Received: from [203.152.41.3] ([203.152.41.3]:6302 "EHLO picard.ine.co.th")
	by vger.kernel.org with ESMTP id S261786AbULUQXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 11:23:25 -0500
Subject: Re: kernel (64bit) 4GB memory support
From: Rudolf Usselmann <rudi@asics.ws>
Reply-To: rudi@asics.ws
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: "Frank Denis (Jedi/Sector One)" <j@pureftpd.org>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <Pine.LNX.4.61.0412201246180.12334@montezuma.fsmlabs.com>
References: <41BAC68D.6050303@pobox.com> <1102760002.10824.170.camel@cpu0>
	 <41BB32A4.2090301@pobox.com> <1102824735.17081.187.camel@cpu0>
	 <Pine.LNX.4.61.0412112141180.7847@montezuma.fsmlabs.com>
	 <1102828235.17081.189.camel@cpu0>
	 <Pine.LNX.4.61.0412120131570.7847@montezuma.fsmlabs.com>
	 <1102842902.10322.200.camel@cpu0>
	 <Pine.LNX.4.61.0412120934160.14734@montezuma.fsmlabs.com>
	 <1103027130.3650.73.camel@cpu0>  <20041216074905.GA2417@c9x.org>
	 <1103213359.31392.71.camel@cpu0>
	 <Pine.LNX.4.61.0412201246180.12334@montezuma.fsmlabs.com>
Content-Type: text/plain
Organization: ASICS.ws - Solutions for your ASICS & FPGA needs -
Message-Id: <1103646195.3652.196.camel@cpu0>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 21 Dec 2004 23:23:15 +0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-21 at 02:49, Zwane Mwaikambo wrote:
> 
> Rudolf, thanks for collecting that information. Since you said that 
> 2.6.10-rc3 also had similar results it counts out a number of suspects i 
> had in the -mm tree. Could you work towards isolating a working kernel 
> version? You could try these;
> 
> 2.6.8.1
> 2.6.9
> 2.6.9-mm1
> 
> Thanks,
> 	Zwane

Zwane,

is there a more scientific approach to this problem ?

See my problem is that I have a very expensive motherboard
and very expensive simm modules which I already inserted and
removed several dozen times. I would like to avoid doing this
experimenting as much as possible. Specially if there might
be a more contractive way. We don't know if there ever has
been a kernel that has worked with this configuration, right ?

memtest86 seems to detect and test all 4gb just fine. So there
must be some way to find the problem ...

I mean you guys must have a pretty good idea what is going wrong.
Is it possible to add some debugging information ? The latest
mm4-jeda kernel seems to be able to "recover" from panics/crashes.
It doesn't "die" it just kills the offending app (at least thats
my limited understanding).

Kind Regards,
rudi

