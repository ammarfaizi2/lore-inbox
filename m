Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135830AbRD2Qci>; Sun, 29 Apr 2001 12:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135831AbRD2QcT>; Sun, 29 Apr 2001 12:32:19 -0400
Received: from dsl-64-128-37-73.telocity.com ([64.128.37.73]:57362 "EHLO
	nic.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S135830AbRD2QcM>; Sun, 29 Apr 2001 12:32:12 -0400
Message-Id: <4.3.2.7.2.20010429122734.00c8b100@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sun, 29 Apr 2001 12:32:08 -0400
To: "Steve 'Denali' McKnelly" <denali@sunflower.com>
From: David Relson <relson@osagesoftware.com>
Subject: RE: 2.4.3 2.4.4pre8: aic7xxx showstopper bug fails to detect
  sda
Cc: "Linux-Kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <PGEDKPCOHCLFJBPJPLNMCEDOCMAA.denali@sunflower.com>
In-Reply-To: <20010429122546.A1419@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

