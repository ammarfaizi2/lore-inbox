Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293008AbSCORz1>; Fri, 15 Mar 2002 12:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293010AbSCORzR>; Fri, 15 Mar 2002 12:55:17 -0500
Received: from gold.he.net ([216.218.149.2]:56594 "EHLO gold.he.net")
	by vger.kernel.org with ESMTP id <S293008AbSCORzC>;
	Fri, 15 Mar 2002 12:55:02 -0500
Reply-To: <jss@pacbell.net>
From: "J.S.S." <jss@pacbell.net>
To: "Marek Malowidzki" <malowidz@wil.waw.pl>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: Default kernel configuration
Date: Fri, 15 Mar 2002 09:58:22 -0800
Message-ID: <PGEMINDOPMDNMJINCKBNMEIMCEAA.jss@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
In-Reply-To: <001501c1cba9$efce22a0$0c765194@wil.waw.pl>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your default configuration for Redhat is in /usr/src/linux-2.4/configs/
Choose one of the few there - probably the kernel-2.4.7-i686.config file.

			J.S.Souza

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Marek Malowidzki
Sent: Thursday, March 14, 2002 2:45 PM
To: linux-kernel@vger.kernel.org
Subject: Default kernel configuration


Hi all,

I hope that this question is not too simple for this list. After many
attempts I
finally gave up and ask for some help.

I would like to recompile the kernel (after some code modification - no
hacking,
just a research project). So the first step would be to try to recompile the
kernel in the default (that is, installed) configuration. But where is it
(the
config file)? /usr/src/linux-2.4/.config is far from the installed
configuration. Should it be
/usr/src/linux-2.4.7-10/configs/kernel-2.4.7-10-i686.config? When I copy
this
file to /usr/src/linux-2.4/.config and perform make dep, make clean and make
bzImage, I get errors in apic.c (e.g. 389: nmi_watchdog undefined, and some
more
undefined symbols).

So my question is: where is the config file with the default (installation)
configuration?

RedHat 7.2, kernel 2.4.7-10, Pentium II machine.

Best regards,

Marek


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

