Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267654AbTASPua>; Sun, 19 Jan 2003 10:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267661AbTASPua>; Sun, 19 Jan 2003 10:50:30 -0500
Received: from tomts13-srv.bellnexxia.net ([209.226.175.34]:61853 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267654AbTASPua>; Sun, 19 Jan 2003 10:50:30 -0500
Subject: Re: Status of ide-cdrom writing?
From: Shane Shrybman <shrybman@sympatico.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1042991971.2625.5.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 19 Jan 2003 10:59:31 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[..SNIP..]
 
Starting to write CD/DVD at speed 1 in real SAO mode for single session.
Last chance to quit, starting real write in 9 seconds. 0.28% done,
estimate finish Sun Jan 12 22:32:14 2003 
  0.56% done, estimate finish Sun Jan 12 22:29:15 2003 
  0.84% done, estimate finish Sun Jan 12 22:28:15 2003 
  1.12% done, estimate finish Sun Jan 12 22:27:45 2003 
   8 seconds. 1.39% done, estimate finish Sun Jan 12 22:28:39 2003 
  1.67% done, estimate finish Sun Jan 12 22:28:15 2003 
   0 seconds. Operation starts. 
Waiting for reader process to fill input buffer ... input buffer ready. 
BURN-Free is ON. 
Starting new track at sector: 0 
Track 01: 4 of 3502 MB written (fifo 99%) 13.1x.cdrecord-prodvd:
Input/output error. write_g1: scsi sendcmd: no error 
CDB: 2A 00 00 00 08 B8 00 00 1F 00 
status: 0x1 (GOOD STATUS) 
resid: 63488 
cmd finished after 0.011s timeout 100s 

I am using 2.5.59-mm2 and cd writing seems to work well if you don't use
SAO/DAO mode, use TAO instead. My drive claims to support SAO and it
used to work with ide-scsi but I get the same error as you if I try SAO
now.

Regards,

Shane 

