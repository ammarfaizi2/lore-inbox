Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWDXIuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWDXIuS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 04:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWDXIuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 04:50:18 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:38284 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S932091AbWDXIuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 04:50:17 -0400
Message-ID: <444C913B.3020706@free.fr>
Date: Mon, 24 Apr 2006 10:50:03 +0200
From: Bernard Pidoux <bpidoux@free.fr>
User-Agent: Thunderbird 1.5 (X11/20060225)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jiri Slaby <jirislaby@gmail.com>, Bernard Pidoux <pidoux@ccr.jussieu.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: [kernel 2.6] Patch for mxser.c driver
References: <443C1DA0.1030004@ccr.jussieu.fr>  <443C2BF4.6070106@gmail.com> <1144834562.1952.31.camel@localhost.localdomain>
In-Reply-To: <1144834562.1952.31.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The multiport serial adapter I wanted to use is a four ports C104H/PCI 
SmartIO.

I just received from Moxa support a beta version of the driver 
(mxser_1.9.1.tgz).

Acording to readme.txt file

    The Smartio/Industio/UPCI family Linux driver supports following 
multiport
    boards.

     - 2 ports multiport board
         CP-102U, CP-102UL
         CP-132U-I, CP-132UL,
         CP-132, CP-132I, CP132S, CP-132IS,
         CI-132, CI-132I, CI-132IS,
         (C102H, C102HI, C102HIS, C102P, CP-102, CP-102S)

     - 4 ports multiport board
         CP-104EL,
         CP-104UL, CP-104JU,
         CP-134U, CP-134U-I
         C104H/PCI, C104HS/PCI,
         CP-114, CP-114I, CP-114S, CP-114IS,
         C104H, C104HS,
         CI-104J, CI-104JS
         CI-134, CI-134I, CI-134IS,
         (C114HI, CT-114I, C104P)

     - 8 ports multiport board
         CP-118EL, CP-168EL,
         CP-118U, CP-168U,
         C168H/PCI,
         C168H, C168HS,
         (C168P)

I did not have any problem to compile this beta version of driver 1.9 
and utilities under kernel 2.6.16 with gcc 4.0.3

73 de Bernard, f6bvp

http://f6bvp.org
http://rose.fpac.free.fr/MINI-HOWTO/
http://rose.fpac.free.fr/MINI-HOWTO-FR/
