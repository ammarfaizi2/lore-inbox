Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270967AbTGVRqV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 13:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270968AbTGVRqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 13:46:21 -0400
Received: from nouse194035.ris.at ([212.52.194.36]:54744 "EHLO
	mail.gibraltar.at") by vger.kernel.org with ESMTP id S270967AbTGVRqT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 13:46:19 -0400
Message-ID: <3F1D7C80.6020605@gibraltar.at>
Date: Tue, 22 Jul 2003 20:03:44 +0200
From: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.3.1-3 StumbleUpon/1.73
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jason Baron <jbaron@redhat.com>, vda@port.imtp.ilyichevsk.odessa.ua,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pivot_root seems to be broken in 2.4.21-ac4
References: <Pine.LNX.4.44.0307221331090.2754-100000@dhcp64-178.boston.redhat.com> <1058895650.4161.23.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1058895650.4161.23.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Alan Cox wrote:
> Shouldnt really have changed anything except for security exploits and
> threaded apps doing weird stuff. In normal situations the files count is
> one so we should actually be executing nothing more exciting that an
> atomic_inc/atomic_dec.
> 
> I wonder what is going on here.
If it is not expected behaviour that the kernel processes no longer 
close their fds open an pivot_root, then I'd like to debug this (is my 
use of pivot_root correct or am I doing something wrong here ?). I will 
try with vanilla 2.4.21 now and see how that goes (or should I rather 
try 2.4.22-pre7 ?).
However, I'd like to use your tree on that machine because of the 
support for VIA chipsets (it's a VIA EPIA M-6000).

Thanks for the notice that it should not have changed,
Rene

