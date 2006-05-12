Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWELNmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWELNmV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 09:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbWELNmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 09:42:21 -0400
Received: from ntwklan-62-233-162-146.devs.futuro.pl ([62.233.162.146]:46564
	"EHLO mail.softwaremind.pl") by vger.kernel.org with ESMTP
	id S932066AbWELNmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 09:42:20 -0400
From: Marcin Hlybin <marcin.hlybin@swmind.com>
To: linux-kernel@vger.kernel.org, Florian Lohoff <flo@rfc822.org>,
       Andrew Burgess <aab@cichlid.com>
Subject: Re: 3ware 8006-2LP on Linux 2.6 drive error, seagate disks
Date: Fri, 12 May 2006 15:43:31 +0200
User-Agent: KMail/1.8.2
References: <200604261732.31327.marcin.hlybin@swmind.com>
In-Reply-To: <200604261732.31327.marcin.hlybin@swmind.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605121543.31349.marcin.hlybin@swmind.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 of April 2006 17:32, Marcin Hlybin wrote:

> Apr 26 15:07:10 krenn kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, 
> flags = 0xc, unit #0.

Ok, I've solved my problem by changing SATA cables. I have tested controller 
with massive I/O operations with both enabled and disabled write-caching. 
Admittedly next day TK server crashed with NMI, parity errors and so on, but 
now I have new mainboard, new riser and everything works just fine. 
I use tw_cli to maintain the RAID. 

Regards

-- 
 Marcin Hlybin, marcin.hlybin (at) swmind.com
 Sys/Net Administrator, tel. +48 12 2523 402

 SoftwareMind, www.softwaremind.pl | Where quality meets the future
