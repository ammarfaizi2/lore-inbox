Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288276AbSAQH6d>; Thu, 17 Jan 2002 02:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288280AbSAQH6X>; Thu, 17 Jan 2002 02:58:23 -0500
Received: from mail.spylog.com ([194.67.35.220]:1498 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S288276AbSAQH6H>;
	Thu, 17 Jan 2002 02:58:07 -0500
Date: Thu, 17 Jan 2002 10:58:00 +0300
From: Andrey Nekrasov <andy@spylog.ru>
To: linux-kernel@vger.kernel.org
Subject: "SCSI storage controller: Adaptec 7896"
Message-ID: <20020117075800.GB3774@spylog.ru>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

1. hardware - m/b Intel L440GX
2. software - 2.4.18pre2aa2

...
SCSI disk error : host 1 channel 0 id 0 lun 0 return code = 8000002
Current sd08:41: sense key Aborted Command
Additional sense indicates Scsi parity error
 I/O error: dev 08:41, sector 1776600
raid1: Disk failure on sde1, disabling device. 
        Operation continuing on 1 devices
md: recovery thread got woken up ...
md2: no spare disk to reconstruct array! -- continuing in degraded mode
md: recovery thread finished ...

3.

@samson:/proc/scsi$ cat scsi 
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDYS-T36950M     Rev: S80D
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DDYS-T36950M     Rev: S80D
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: DDYS-T36950M     Rev: S80D
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: IBM      Model: DDYS-T18350M     Rev: S96H
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DNES-318350W     Rev: SAH0
  Type:   Direct-Access                    ANSI SCSI revision: 03
@samson:/proc/scsi$ 

4.

This is error disk or scsi cable?
Way not repeat try I/O ?

-- 
bye.
Andrey Nekrasov, SpyLOG.
