Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286893AbSAPSb4>; Wed, 16 Jan 2002 13:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286221AbSAPSbs>; Wed, 16 Jan 2002 13:31:48 -0500
Received: from mail.fido.net ([194.70.36.10]:14732 "EHLO
	monty.test.eng.fido.net") by vger.kernel.org with ESMTP
	id <S286262AbSAPSb1>; Wed, 16 Jan 2002 13:31:27 -0500
X-Header: FidoNet Virus Scanned
Message-ID: <014501c19ebb$fe9adf00$308d14ac@tosh>
Reply-To: "Shaf Ali" <shaf@shaf.net>
From: "Shaf Ali" <shaf@shaf.net>
To: <linux-admin@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <jdomingo@internautas.org>
In-Reply-To: <1010951831.3241.0.camel@penarol01> <15425.60130.574569.697952@cerise.nosuchdomain.co.uk> <002a01c19dab$4de66dc0$a52efea9@tosh>
Subject: Re: 2.4.17 instability with i2c ?
Date: Wed, 16 Jan 2002 18:31:20 -0000
Organization: ContentFusion.com
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jose for your input...

Apparently the culprit was not the the i2c modules afterall....
It was ntop in conjunction with iptables/ians (Intel load balancing
module)...
The macnine is still up after the removal of ntop.

Shaf



----- Original Message -----
From: "Shaf Ali" <shaf@shaf.net>
To: <linux-admin@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, January 15, 2002 9:59 AM
Subject: 2.4.17 instability with i2c ?


> Hi again,
>
> I am having problems with a machine and cannot pin down why it's abruptly
> rebooting...
> I can find no messages in any of the logs !
>
> My theories are pointing the blame towards the following configuration :
> Redhat 7.2
> kernel 2.4.17 patched with i2c-2.6.2.tar.gz.
>
> I am about to attempt building a a fresh kernel... can anyone recommmend a
> stable kernel or has anyone experienced problems with 2.4.17 patched with
> i2c ?
>
> Many thanks in advance,
> Shaf
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-admin" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

