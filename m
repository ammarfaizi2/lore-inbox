Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVF0TqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVF0TqS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVF0Tn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:43:57 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:31649 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261243AbVF0Tm4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:42:56 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Stefano Mangione <s.mangione@gmail.com>
Subject: Re: [2.6.12] USB storage device stalls after a few KB transfer
Date: Mon, 27 Jun 2005 20:42:51 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <2d4e1ff6050627115141bb2828@mail.gmail.com>
In-Reply-To: <2d4e1ff6050627115141bb2828@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506272042.51578.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 Jun 2005 19:51, Stefano Mangione wrote:
> The device is seen, can be mounted and the filesystem listed, but file
> transfers run very slow, i guess they stop after a few KB.
>
> This happened in 2.6.12, 2.6.11.12 works well, everything else seems
> to work perfectly. The device is a 256MB OTi Flash Disk, my USB host
> is listed as a VIA VT6202, the motherboard is an MSI with A6712VMS
> V1.9 072903 BIOS
>
> /sbin/lspci -n:
> 00:10.0 Class 0c03: 1106:3038 (rev 80)
> 00:10.1 Class 0c03: 1106:3038 (rev 80)
> 00:10.2 Class 0c03: 1106:3038 (rev 80)
> 00:10.3 Class 0c03: 1106:3104 (rev 82)

I get the same problem on an Intel laptop. Sometimes it works, sometimes it 
doesn't. I'm in the process of tracking it down..

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
