Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287189AbSAXR1p>; Thu, 24 Jan 2002 12:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288238AbSAXR1f>; Thu, 24 Jan 2002 12:27:35 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:64407
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S287189AbSAXR1Y>; Thu, 24 Jan 2002 12:27:24 -0500
Date: Thu, 24 Jan 2002 12:35:58 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.16
Message-ID: <20020124123558.A19899@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

recent 2.4 kernels seem to love eating away at memory.  After 2 weeks of
uptime, 2.2.19 would normally consume about 120mb of ram and maybe 1mb of
swap.  With 2.4.16 it's more than doubled.  Swap usage is 128mb, memory
useage about 230mb.  Nothing is different between what I ran with 2.2 and
what I run now with 2.4.

Is linux trying to do memory consumtion like windows now?

The other odd thing is, when I go to single user (init 1), I still have
100-120mb memory used.  Only thing running is the shell init and kernel
processes.  This is after all modules have been unloaded as well (my kernel
only has what it takes to mount / and nothing more)  Where is this memory
going?  I shouldn't have THAT much used with nothing running.

memory: 512mb
swap:   130mb (2 65mb partitions on scsi)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
