Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbUKRKsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbUKRKsL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 05:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbUKRK25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 05:28:57 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:44928 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262724AbUKRK1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 05:27:55 -0500
Date: Thu, 18 Nov 2004 11:27:41 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-os@analogic.com
cc: Sharma Sushant <sushant@cs.unm.edu>, linux-kernel@vger.kernel.org
Subject: Re: max agruments in system_calls
In-Reply-To: <Pine.LNX.4.61.0411171839430.1111@chaos.analogic.com>
Message-ID: <Pine.LNX.4.53.0411181127170.26614@yvahk01.tjqt.qr>
References: <Pine.LNX.4.60.0411171608250.30215@chawla.cs.unm.edu>
 <Pine.LNX.4.61.0411171839430.1111@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Huh? You KNOW that you don't have more than 7 registers available
>on ix86 so you KNOW that you either need a pointer to a struct (one
>parameter) or it won't work.
>
>FYI:
> 	eax = function code
> 	ebx = first parameter
> 	ecx = second parameter
> 	edx = third parameter
> 	esi = fourth parameter
> 	edi = fifth parameter
> 	ebp = sixth parameter

And if you use varargs?



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
