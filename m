Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbVFUJqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVFUJqn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 05:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVFUIJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:09:14 -0400
Received: from femail.waymark.net ([206.176.148.84]:670 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S261729AbVFUGrq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:47:46 -0400
Date: 21 Jun 2005 04:40:32 GMT
From: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>
Subject: Re: [PATCH] Hidden SMBus bridge on Toshiba Tecra M2
To: linux-kernel@vger.kernel.org
Message-ID: <103fb1.d4bd10@family-bbs.org>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-=> Daniele Gaffuri wrote to Greg KH <=-

here it looks ...

 DG>                         }=0A=
 DG> +               if (dev->device =3D=3D
 DG> PCI_DEVICE_ID_INTEL_82855PM_HB)=0A= +
 DG> switch(dev->subsystem_device) {=0A= +                       case
 DG> 0x0001: /* Toshiba Tecra M2 */=0A= +
 DG> asus_hides_smbus =3D 1;=0A= +                       }=0A=
 DG>         } else if (unlikely(dev->subsystem_vendor =3D=3D =
 DG> PCI_VENDOR_ID_SAMSUNG)) {=0A=
 DG>                 if (dev->device =3D=3D
 DG> PCI_DEVICE_ID_INTEL_82855PM_HB)=0A=
 DG>                         switch(dev->subsystem_device) {=0A=

--- MultiMail/Linux v0.46
