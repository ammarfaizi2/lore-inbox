Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132895AbRD2XhD>; Sun, 29 Apr 2001 19:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132993AbRD2Xgw>; Sun, 29 Apr 2001 19:36:52 -0400
Received: from smtp.sunflower.com ([24.124.0.137]:27155 "EHLO
	smtp.sunflower.com") by vger.kernel.org with ESMTP
	id <S132895AbRD2Xgl>; Sun, 29 Apr 2001 19:36:41 -0400
From: "Steve 'Denali' McKnelly" <denali@sunflower.com>
To: "David Relson" <relson@osagesoftware.com>
Cc: "Linux-Kernel mailing list" <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.3 2.4.4pre8: aic7xxx showstopper bug fails to detect sda
Date: Sun, 29 Apr 2001 18:36:39 -0500
Message-ID: <PGEDKPCOHCLFJBPJPLNMOEEMCMAA.denali@sunflower.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <4.3.2.7.2.20010429122734.00c8b100@mail.osagesoftware.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh... It doesn't even get that far... It just dies with the
undefined symbols...

-----Original Message-----
From: David Relson [mailto:relson@osagesoftware.com]
Sent: Sunday, April 29, 2001 11:32 AM
To: Steve 'Denali' McKnelly
Cc: Linux-Kernel mailing list
Subject: RE: 2.4.3 2.4.4pre8: aic7xxx showstopper bug fails to detect
sda


At 12:17 PM 4/29/01, Steve 'Denali' McKnelly wrote:
>Howdy J.A.,
>
>         Let me ask a possibly stupid question... How do you tell
>what version of the Gibbs Adaptec driver you're using?  Did I
>misunderstand you when you said the 2.4.4 kernel is using 6.1.5?
>Also, did I understand you to say the 6.1.12 version will fix
>my unresolved symbol problem?
>
>Thanks,
>Steve

Steve,

A message saying (roughly) AIC7XXX 6.1.xxx appears while the kernel is 
loading.  You can also grep the aic7xxx.c source file or run the strings 
command ( strings /lib/modules/2.4.4/kernel/drivers/scsi/aic7xxx ).

I'm not sure about your undefined symbols problem, but I was able to build 
2.4.4 with 6.1.11 with no trouble.

David

--------------------------------------------------------
David Relson                   Osage Software Systems, Inc.
relson@osagesoftware.com       Ann Arbor, MI 48103
www.osagesoftware.com          tel:  734.821.8800

