Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280821AbRKLP6I>; Mon, 12 Nov 2001 10:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280822AbRKLP57>; Mon, 12 Nov 2001 10:57:59 -0500
Received: from moon.govshops.com ([207.32.111.5]:58376 "HELO mail.govshops.com")
	by vger.kernel.org with SMTP id <S280821AbRKLP5u>;
	Mon, 12 Nov 2001 10:57:50 -0500
From: "Alok K. Dhir" <alok@dhir.net>
To: "'Kristian'" <kristian@korseby.net>, <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.15pre1-Oops with netfilter
Date: Mon, 12 Nov 2001 10:56:52 -0500
Message-ID: <001f01c16b92$a54cb6f0$9865fea9@pcsn630778>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <3BEFE601.4050808@korseby.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is likely the same bug that I and a few others on this list
experienced.  Back out the 4 netfilter patches which went into -pre1 and
it should work again.

Look for the message with the subject "Confirm netfilter: repeatable
oops in 2.4.15-pre2" in the archives and it has the patches attached
which you should reverse apply to your tree.

Al

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Kristian
> Sent: Monday, November 12, 2001 10:09 AM
> To: linux-kernel@vger.kernel.org
> Subject: 2.4.15pre1-Oops with netfilter
> 
> 
> Hello.
> 
> This nice oops is repeatable. After successfully connecting 
> (via ISDN) to the 
> internet I'm getting this oops when I'm trying to transfer 
> something. I'm currently using iptables-1.2.4 & 2.4.15pre1 if 
> it's relevant.
> 
> If you need additional info just let me know.
> 
> *Kristian
> 
> -- 
> .. . . reach me :: . .. .. .  . .. . ..  . ... . .
>                           :: http://www.korseby.net
>                           :: http://www.tomlab.de 
> kristian@korseby.net ....::
> 

