Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261323AbSJULMJ>; Mon, 21 Oct 2002 07:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261322AbSJULMI>; Mon, 21 Oct 2002 07:12:08 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:37299 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261323AbSJULMH>; Mon, 21 Oct 2002 07:12:07 -0400
Subject: Re: Any hope of fixing shutdown power off for SMP?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: landley@trommello.org
Cc: Bill Davidsen <davidsen@tmr.com>, Jurriaan <thunder7@xs4all.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200210202058.29291.landley@trommello.org>
References: <Pine.LNX.3.96.1021020224417.1655G-100000@gatekeeper.tmr.com> 
	<200210202058.29291.landley@trommello.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 12:32:36 +0100
Message-Id: <1035199956.27318.36.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-21 at 02:58, Rob Landley wrote:
> None of my systems will power down on UP if I enable the "local apic support 
> on uniprocessors" option.

Its a very common BIOS problem. Some work was done on switching back
from APIC in this situation but its not really proved sufficient - I
still dont understand why. With 2.5 we have ACPI thats now getting
actually usable and that should let the power off stuff beging to do the
right thing

