Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270824AbTHLQou (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 12:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270847AbTHLQou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 12:44:50 -0400
Received: from fw1.masirv.com ([65.205.206.2]:45901 "EHLO NEWMAN.masirv.com")
	by vger.kernel.org with ESMTP id S270824AbTHLQos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 12:44:48 -0400
Message-ID: <1060653362.5294.58.camel@huykhoi>
From: Anthony Truong <Anthony.Truong@mascorp.com>
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: linux kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: generic strncpy - off-by-one error
Date: Mon, 11 Aug 2003 18:56:02 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-13 at 00:24, Bernd Petrovitsch wrote:

>I don't see any problem with this code, and if we don't need to
>NULL-pad the dest string, we do not have to.  It is not in the
>definition of strncpy(). 

Wrong: http://www.opengroup.org/onlinepubs/007908799/xsh/strncpy.html

        Bernd

Hello,
Thanks for pointing that out to me.  However, I don't think the kernel
strncpy implementation is exactly the same as that of Standard C lib
implementation.  Iwas just looking at it from the kernel code context. 
There's a point in doing it the "kernel" way, to save precious CPU
cycles from being wasted otherwise.

Regards,
Anthony Dominic Truong.



Disclaimer: The information contained in this transmission, including any
attachments, may contain confidential information of Matsushita Avionics
Systems Corporation.  This transmission is intended only for the use of the
addressee(s) listed above.  Unauthorized review, dissemination or other use
of the information contained in this transmission is strictly prohibited.
If you have received this transmission in error or have reason to believe
you are not authorized to receive it, please notify the sender by return
email and promptly delete the transmission.


