Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132961AbRDJJIp>; Tue, 10 Apr 2001 05:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132967AbRDJJIf>; Tue, 10 Apr 2001 05:08:35 -0400
Received: from alpham.uni-mb.si ([164.8.1.101]:54792 "EHLO alpham.uni-mb.si")
	by vger.kernel.org with ESMTP id <S132961AbRDJJIU>;
	Tue, 10 Apr 2001 05:08:20 -0400
Date: Tue, 10 Apr 2001 11:07:24 +0200
From: Igor Mozetic <igor.mozetic@uni-mb.si>
Subject: Re: aic7xxx and 2.4.3 failures
To: jim@federated.com, linux-kernel@vger.kernel.org
Message-id: <3AD2CD4C.EF8E7292@uni-mb.si>
Organization: CAMTP
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For me 2.4.3 + aic7xxx-6.1.10 work fine. I just changed the default
bus settle delay from 15000ms to 5000m, and enabled APIC:
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y

The machine boots, devices are properly detected (unlike 6.1.8),
CDRW reads and burns fine, CDROM works (IDE-SCSI).

Intel C440GX+ UP, Adaptec AIC-7896/7, 2GB RAM, CDRW Sony CDU948 4x/8x

-Igor Mozetic
