Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVB1PQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVB1PQW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 10:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVB1PQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 10:16:22 -0500
Received: from imag.imag.fr ([129.88.30.1]:20702 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S261633AbVB1PQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 10:16:20 -0500
Message-ID: <1109603775.422335bfa0e62@webmail.imag.fr>
Date: Mon, 28 Feb 2005 16:16:15 +0100
From: colbuse@ensisun.imag.fr
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] drivers/chat/vt.c: remove unnecessary code
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 193.49.124.107
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Mon, 28 Feb 2005 16:16:16 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>On Mon, Feb 28, 2005 at 01:55:28PM +0100, colbuse@xxxxxxxxxxxxxxx wrote:
>
>> Avoid changing the state of the console two times in some cases.
>
>A bad change for several reasons.
>
>(i) more object code is generated
>(ii) the code is slower
>(iii) you change something
>
>Straight line code is cheap, jumps are expensive.
>Replacing an assignment by a jump is not an improvement.


I didn't thought to that point... 

You're right, this patch was a bad idea :(.

Sorry about this error...

--
Emmanuel Colbus
Club GNU/Linux
ENSIMAG - Departement telecoms

-------------------------------------------------
envoyé via Webmail/IMAG !

