Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264040AbTFDUcS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 16:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264050AbTFDUcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 16:32:17 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:52216 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264040AbTFDUab
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 16:30:31 -0400
Date: Wed, 04 Jun 2003 13:32:15 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: mm3 hang
Message-ID: <1274420000.1054758735@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SDET hangs it every few runs.

Script started on Wed Jun  4 13:19:11 2003
SysRq : Show Memory
Mem-info:
Node 0 DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
cpu 2 hot: low 2, high 6, batch 1
cpu 2 cold: low 0, high 2, batch 1
cpu 3 hot: low 2, high 6, batch 1
cpu 3 cold: low 0, high 2, batch 1
cpu 4 hot: low 2, high 6, batch 1
cpu 4 cold: low 0, high 2, batch 1
cpu 5 hot: low 2, high 6, batch 1
cpu 5 cold: low 0, high 2, batch 1
cpu 6 hot: low 2, high 6, batch 1
cpu 6 cold: low 0, high 2, batch 1
cpu 7 hot: low 2, high 6, batch 1
cpu 7 cold: low 0, high 2, batch 1
cpu 8 hot: low 2, high 6, batch 1
cpu 8 cold: low 0, high 2, batch 1
cpu 9 hot: low 2, high 6, batch 1
cpu 9 cold: low 0, high 2, batch 1
cpu 10 hot: low 2, high 6, batch 1
cpu 10 cold: low 0, high 2, batch 1
cpu 11 hot: low 2, high 6, batch 1
cpu 11 cold: low 0, high 2, batch 1
cpu 12 hot: low 2, high 6, batch 1
cpu 12 cold: low 0, high 2, batch 1
cpu 13 hot: low 2, high 6, batch 1
cpu 13 cold: low 0, high 2, batch 1
cpu 14 hot: low 2, high 6, batch 1
cpu 14 cold: low 0, high 2, batch 1
cpu 15 hot: low 2, high 6, batch 1
cpu 15 cold: low 0, high 2, batch 1
cpu 16 hot: low 2, high 6, batch 1
cpu 16 cold: low 0, high 2, batch 1
cpu 17 hot: low 2, high 6, batch 1
cpu 17 cold: low 0, high 2, batch 1
cpu 18 hot: low 2, high 6, batch 1
cpu 18 cold: low 0, high 2, batch 1
cpu 19 hot: low 2, high 6, batch 1
cpu 19 cold: low 0, high 2, batch 1
cpu 20 hot: low 2, high 6, batch 1
cpu 20 cold: low 0, high 2, batch 1
cpu 21 hot: low 2, high 6, batch 1
cpu 21 cold: low 0, high 2, batch 1
cpu 22 hot: low 2, high 6, batch 1
cpu 22 cold: low 0, high 2, batch 1
cpu 23 hot: low 2, high 6, batch 1
cpu 23 cold: low 0, high 2, batch 1
cpu 24 hot: low 2, high 6, batch 1
cpu 24 cold: low 0, high 2, batch 1
cpu 25 hot: low 2, high 6, batch 1
cpu 25 cold: low 0, high 2, batch 1
cpu 26 hot: low 2, high 6, batch 1
cpu 26 cold: low 0, high 2, batch 1
cpu 27 hot: low 2, high 6, batch 1
cpu 27 cold: low 0, high 2, batch 1
cpu 28 hot: low 2, high 6, batch 1
cpu 28 cold: low 0, high 2, batch 1
cpu 29 hot: low 2, high 6, batch 1
cpu 29 cold: low 0, high 2, batch 1
cpu 30 hot: low 2, high 6, batch 1
cpu 30 cold: low 0, high 2, batch 1
cpu 31 hot: low 2, high 6, batch 1
cpu 31 cold: low 0, high 2, batch 1
Node 0 Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
cpu 4 hot: low 32, high 96, batch 16
cpu 4 cold: low 0, high 32, batch 16
cpu 5 hot: low 32, high 96, batch 16
cpu 5 cold: low 0, high 32, batch 16
cpu 6 hot: low 32, high 96, batch 16
cpu 6 cold: low 0, high 32, batch 16
cpu 7 hot: low 32, high 96, batch 16
cpu 7 cold: low 0, high 32, batch 16
cpu 8 hot: low 32, high 96, batch 16
cpu 8 cold: low 0, high 32, batch 16
cpu 9 hot: low 32, high 96, batch 16
cpu 9 cold: low 0, high 32, batch 16
cpu 10 hot: low 32, high 96, batch 16
cpu 10 cold: low 0, high 32, batch 16
cpu 11 hot: low 32, high 96, batch 16
cpu 11 cold: low 0, high 32, batch 16
cpu 12 hot: low 32, high 96, batch 16
cpu 12 cold: low 0, high 32, batch 16
cpu 13 hot: low 32, high 96, batch 16
cpu 13 cold: low 0, high 32, batch 16
cpu 14 hot: low 32, high 96, batch 16
cpu 14 cold: low 0, high 32, batch 16
cpu 15 hot: low 32, high 96, batch 16
cpu 15 cold: low 0, high 32, batch 16
cpu 16 hot: low 32, high 96, batch 16
cpu 16 cold: low 0, high 32, batch 16
cpu 17 hot: low 32, high 96, batch 16
cpu 17 cold: low 0, high 32, batch 16
cpu 18 hot: low 32, high 96, batch 16
cpu 18 cold: low 0, high 32, batch 16
cpu 19 hot: low 32, high 96, batch 16
cpu 19 cold: low 0, high 32, batch 16
cpu 20 hot: low 32, high 96, batch 16
cpu 20 cold: low 0, high 32, batch 16
cpu 21 hot: low 32, high 96, batch 16
cpu 21 cold: low 0, high 32, batch 16
cpu 22 hot: low 32, high 96, batch 16
cpu 22 cold: low 0, high 32, batch 16
cpu 23 hot: low 32, high 96, batch 16
cpu 23 cold: low 0, high 32, batch 16
cpu 24 hot: low 32, high 96, batch 16
cpu 24 cold: low 0, high 32, batch 16
cpu 25 hot: low 32, high 96, batch 16
cpu 25 cold: low 0, high 32, batch 16
cpu 26 hot: low 32, high 96, batch 16
cpu 26 cold: low 0, high 32, batch 16
cpu 27 hot: low 32, high 96, batch 16
cpu 27 cold: low 0, high 32, batch 16
cpu 28 hot: low 32, high 96, batch 16
cpu 28 cold: low 0, high 32, batch 16
cpu 29 hot: low 32, high 96, batch 16
cpu 29 cold: low 0, high 32, batch 16
cpu 30 hot: low 32, high 96, batch 16
cpu 30 cold: low 0, high 32, batch 16
cpu 31 hot: low 32, high 96, batch 16
cpu 31 cold: low 0, high 32, batch 16
Node 0 HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
cpu 4 hot: low 32, high 96, batch 16
cpu 4 cold: low 0, high 32, batch 16
cpu 5 hot: low 32, high 96, batch 16
cpu 5 cold: low 0, high 32, batch 16
cpu 6 hot: low 32, high 96, batch 16
cpu 6 cold: low 0, high 32, batch 16
cpu 7 hot: low 32, high 96, batch 16
cpu 7 cold: low 0, high 32, batch 16
cpu 8 hot: low 32, high 96, batch 16
cpu 8 cold: low 0, high 32, batch 16
cpu 9 hot: low 32, high 96, batch 16
cpu 9 cold: low 0, high 32, batch 16
cpu 10 hot: low 32, high 96, batch 16
cpu 10 cold: low 0, high 32, batch 16
cpu 11 hot: low 32, high 96, batch 16
cpu 11 cold: low 0, high 32, batch 16
cpu 12 hot: low 32, high 96, batch 16
cpu 12 cold: low 0, high 32, batch 16
cpu 13 hot: low 32, high 96, batch 16
cpu 13 cold: low 0, high 32, batch 16
cpu 14 hot: low 32, high 96, batch 16
cpu 14 cold: low 0, high 32, batch 16
cpu 15 hot: low 32, high 96, batch 16
cpu 15 cold: low 0, high 32, batch 16
cpu 16 hot: low 32, high 96, batch 16
cpu 16 cold: low 0, high 32, batch 16
cpu 17 hot: low 32, high 96, batch 16
cpu 17 cold: low 0, high 32, batch 16
cpu 18 hot: low 32, high 96, batch 16
cpu 18 cold: low 0, high 32, batch 16
cpu 19 hot: low 32, high 96, batch 16
cpu 19 cold: low 0, high 32, batch 16
cpu 20 hot: low 32, high 96, batch 16
cpu 20 cold: low 0, high 32, batch 16
cpu 21 hot: low 32, high 96, batch 16
cpu 21 cold: low 0, high 32, batch 16
cpu 22 hot: low 32, high 96, batch 16
cpu 22 cold: low 0, high 32, batch 16
cpu 23 hot: low 32, high 96, batch 16
cpu 23 cold: low 0, high 32, batch 16
cpu 24 hot: low 32, high 96, batch 16
cpu 24 cold: low 0, high 32, batch 16
cpu 25 hot: low 32, high 96, batch 16
cpu 25 cold: low 0, high 32, batch 16
cpu 26 hot: low 32, high 96, batch 16
cpu 26 cold: low 0, high 32, batch 16
cpu 27 hot: low 32, high 96, batch 16
cpu 27 cold: low 0, high 32, batch 16
cpu 28 hot: low 32, high 96, batch 16
cpu 28 cold: low 0, high 32, batch 16
cpu 29 hot: low 32, high 96, batch 16
cpu 29 cold: low 0, high 32, batch 16
cpu 30 hot: low 32, high 96, batch 16
cpu 30 cold: low 0, high 32, batch 16
cpu 31 hot: low 32, high 96, batch 16
cpu 31 cold: low 0, high 32, batch 16
Node 1 DMA per-cpu: empty
Node 1 Normal per-cpu: empty
Node 1 HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
cpu 4 hot: low 32, high 96, batch 16
cpu 4 cold: low 0, high 32, batch 16
cpu 5 hot: low 32, high 96, batch 16
cpu 5 cold: low 0, high 32, batch 16
cpu 6 hot: low 32, high 96, batch 16
cpu 6 cold: low 0, high 32, batch 16
cpu 7 hot: low 32, high 96, batch 16
cpu 7 cold: low 0, high 32, batch 16
cpu 8 hot: low 32, high 96, batch 16
cpu 8 cold: low 0, high 32, batch 16
cpu 9 hot: low 32, high 96, batch 16
cpu 9 cold: low 0, high 32, batch 16
cpu 10 hot: low 32, high 96, batch 16
cpu 10 cold: low 0, high 32, batch 16
cpu 11 hot: low 32, high 96, batch 16
cpu 11 cold: low 0, high 32, batch 16
cpu 12 hot: low 32, high 96, batch 16
cpu 12 cold: low 0, high 32, batch 16
cpu 13 hot: low 32, high 96, batch 16
cpu 13 cold: low 0, high 32, batch 16
cpu 14 hot: low 32, high 96, batch 16
cpu 14 cold: low 0, high 32, batch 16
cpu 15 hot: low 32, high 96, batch 16
cpu 15 cold: low 0, high 32, batch 16
cpu 16 hot: low 32, high 96, batch 16
cpu 16 cold: low 0, high 32, batch 16
cpu 17 hot: low 32, high 96, batch 16
cpu 17 cold: low 0, high 32, batch 16
cpu 18 hot: low 32, high 96, batch 16
cpu 18 cold: low 0, high 32, batch 16
cpu 19 hot: low 32, high 96, batch 16
cpu 19 cold: low 0, high 32, batch 16
cpu 20 hot: low 32, high 96, batch 16
cpu 20 cold: low 0, high 32, batch 16
cpu 21 hot: low 32, high 96, batch 16
cpu 21 cold: low 0, high 32, batch 16
cpu 22 hot: low 32, high 96, batch 16
cpu 22 cold: low 0, high 32, batch 16
cpu 23 hot: low 32, high 96, batch 16
cpu 23 cold: low 0, high 32, batch 16
cpu 24 hot: low 32, high 96, batch 16
cpu 24 cold: low 0, high 32, batch 16
cpu 25 hot: low 32, high 96, batch 16
cpu 25 cold: low 0, high 32, batch 16
cpu 26 hot: low 32, high 96, batch 16
cpu 26 cold: low 0, high 32, batch 16
cpu 27 hot: low 32, high 96, batch 16
cpu 27 cold: low 0, high 32, batch 16
cpu 28 hot: low 32, high 96, batch 16
cpu 28 cold: low 0, high 32, batch 16
cpu 29 hot: low 32, high 96, batch 16
cpu 29 cold: low 0, high 32, batch 16
cpu 30 hot: low 32, high 96, batch 16
cpu 30 cold: low 0, high 32, batch 16
cpu 31 hot: low 32, high 96, batch 16
cpu 31 cold: low 0, high 32, batch 16
Node 2 DMA per-cpu: empty
Node 2 Normal per-cpu: empty
Node 2 HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
cpu 4 hot: low 32, high 96, batch 16
cpu 4 cold: low 0, high 32, batch 16
cpu 5 hot: low 32, high 96, batch 16
cpu 5 cold: low 0, high 32, batch 16
cpu 6 hot: low 32, high 96, batch 16
cpu 6 cold: low 0, high 32, batch 16
cpu 7 hot: low 32, high 96, batch 16
cpu 7 cold: low 0, high 32, batch 16
cpu 8 hot: low 32, high 96, batch 16
cpu 8 cold: low 0, high 32, batch 16
cpu 9 hot: low 32, high 96, batch 16
cpu 9 cold: low 0, high 32, batch 16
cpu 10 hot: low 32, high 96, batch 16
cpu 10 cold: low 0, high 32, batch 16
cpu 11 hot: low 32, high 96, batch 16
cpu 11 cold: low 0, high 32, batch 16
cpu 12 hot: low 32, high 96, batch 16
cpu 12 cold: low 0, high 32, batch 16
cpu 13 hot: low 32, high 96, batch 16
cpu 13 cold: low 0, high 32, batch 16
cpu 14 hot: low 32, high 96, batch 16
cpu 14 cold: low 0, high 32, batch 16
cpu 15 hot: low 32, high 96, batch 16
cpu 15 cold: low 0, high 32, batch 16
cpu 16 hot: low 32, high 96, batch 16
cpu 16 cold: low 0, high 32, batch 16
cpu 17 hot: low 32, high 96, batch 16
cpu 17 cold: low 0, high 32, batch 16
cpu 18 hot: low 32, high 96, batch 16
cpu 18 cold: low 0, high 32, batch 16
cpu 19 hot: low 32, high 96, batch 16
cpu 19 cold: low 0, high 32, batch 16
cpu 20 hot: low 32, high 96, batch 16
cpu 20 cold: low 0, high 32, batch 16
cpu 21 hot: low 32, high 96, batch 16
cpu 21 cold: low 0, high 32, batch 16
cpu 22 hot: low 32, high 96, batch 16
cpu 22 cold: low 0, high 32, batch 16
cpu 23 hot: low 32, high 96, batch 16
cpu 23 cold: low 0, high 32, batch 16
cpu 24 hot: low 32, high 96, batch 16
cpu 24 cold: low 0, high 32, batch 16
cpu 25 hot: low 32, high 96, batch 16
cpu 25 cold: low 0, high 32, batch 16
cpu 26 hot: low 32, high 96, batch 16
cpu 26 cold: low 0, high 32, batch 16
cpu 27 hot: low 32, high 96, batch 16
cpu 27 cold: low 0, high 32, batch 16
cpu 28 hot: low 32, high 96, batch 16
cpu 28 cold: low 0, high 32, batch 16
cpu 29 hot: low 32, high 96, batch 16
cpu 29 cold: low 0, high 32, batch 16
cpu 30 hot: low 32, high 96, batch 16
cpu 30 cold: low 0, high 32, batch 16
cpu 31 hot: low 32, high 96, batch 16
cpu 31 cold: low 0, high 32, batch 16
Node 3 DMA per-cpu: empty
Node 3 Normal per-cpu: empty
Node 3 HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
cpu 4 hot: low 32, high 96, batch 16
cpu 4 cold: low 0, high 32, batch 16
cpu 5 hot: low 32, high 96, batch 16
cpu 5 cold: low 0, high 32, batch 16
cpu 6 hot: low 32, high 96, batch 16
cpu 6 cold: low 0, high 32, batch 16
cpu 7 hot: low 32, high 96, batch 16
cpu 7 cold: low 0, high 32, batch 16
cpu 8 hot: low 32, high 96, batch 16
cpu 8 cold: low 0, high 32, batch 16
cpu 9 hot: low 32, high 96, batch 16
cpu 9 cold: low 0, high 32, batch 16
cpu 10 hot: low 32, high 96, batch 16
cpu 10 cold: low 0, high 32, batch 16
cpu 11 hot: low 32, high 96, batch 16
cpu 11 cold: low 0, high 32, batch 16
cpu 12 hot: low 32, high 96, batch 16
cpu 12 cold: low 0, high 32, batch 16
cpu 13 hot: low 32, high 96, batch 16
cpu 13 cold: low 0, high 32, batch 16
cpu 14 hot: low 32, high 96, batch 16
cpu 14 cold: low 0, high 32, batch 16
cpu 15 hot: low 32, high 96, batch 16
cpu 15 cold: low 0, high 32, batch 16
cpu 16 hot: low 32, high 96, batch 16
cpu 16 cold: low 0, high 32, batch 16
cpu 17 hot: low 32, high 96, batch 16
cpu 17 cold: low 0, high 32, batch 16
cpu 18 hot: low 32, high 96, batch 16
cpu 18 cold: low 0, high 32, batch 16
cpu 19 hot: low 32, high 96, batch 16
cpu 19 cold: low 0, high 32, batch 16
cpu 20 hot: low 32, high 96, batch 16
cpu 20 cold: low 0, high 32, batch 16
cpu 21 hot: low 32, high 96, batch 16
cpu 21 cold: low 0, high 32, batch 16
cpu 22 hot: low 32, high 96, batch 16
cpu 22 cold: low 0, high 32, batch 16
cpu 23 hot: low 32, high 96, batch 16
cpu 23 cold: low 0, high 32, batch 16
cpu 24 hot: low 32, high 96, batch 16
cpu 24 cold: low 0, high 32, batch 16
cpu 25 hot: low 32, high 96, batch 16
cpu 25 cold: low 0, high 32, batch 16
cpu 26 hot: low 32, high 96, batch 16
cpu 26 cold: low 0, high 32, batch 16
cpu 27 hot: low 32, high 96, batch 16
cpu 27 cold: low 0, high 32, batch 16
cpu 28 hot: low 32, high 96, batch 16
cpu 28 cold: low 0, high 32, batch 16
cpu 29 hot: low 32, high 96, batch 16
cpu 29 cold: low 0, high 32, batch 16
cpu 30 hot: low 32, high 96, batch 16
cpu 30 cold: low 0, high 32, batch 16
cpu 31 hot: low 32, high 96, batch 16
cpu 31 cold: low 0, high 32, batch 16

Free pages:    15807880kB (15159296kB HighMem)
Active:43955 inactive:1903 dirty:29 writeback:0 unstable:0 free:3951970
Node 0 DMA free:13792kB min:20kB low:40kB high:60kB active:0kB inactive:0kB
Node 0 Normal free:634792kB min:1000kB low:2000kB high:3000kB active:28876kB inactive:660kB
Node 0 HighMem free:2836288kB min:512kB low:1024kB high:1536kB active:35516kB inactive:4396kB
Node 1 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
Node 1 Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
Node 1 HighMem free:4115520kB min:512kB low:1024kB high:1536kB active:28960kB inactive:1416kB
Node 2 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
Node 2 Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
Node 2 HighMem free:4097920kB min:512kB low:1024kB high:1536kB active:47016kB inactive:596kB
Node 3 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
Node 3 Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
Node 3 HighMem free:4109568kB min:512kB low:1024kB high:1536kB active:35452kB inactive:544kB
Node 0 DMA: 4*4kB 4*8kB 5*16kB 5*32kB 5*64kB 3*128kB 2*256kB 2*512kB 1*1024kB 1*2048kB 2*4096kB = 13792kB
Node 0 Normal: 1604*4kB 577*8kB 67*16kB 5*32kB 1*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 151*4096kB = 634792kB
Node 0 HighMem: 1044*4kB 844*8kB 357*16kB 78*32kB 10*64kB 56*128kB 24*256kB 3*512kB 0*1024kB 0*2048kB 684*4096kB = 2836288kB
Node 1 DMA: empty
Node 1 Normal: empty
Node 1 HighMem: 996*4kB 644*8kB 247*16kB 61*32kB 30*64kB 2*128kB 1*256kB 0*512kB 0*1024kB 1*2048kB 1000*4096kB = 4115520kB
Node 2 DMA: empty
Node 2 Normal: empty
Node 2 HighMem: 1038*4kB 653*8kB 276*16kB 59*32kB 19*64kB 7*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 996*4096kB = 4097920kB
Node 3 DMA: empty
Node 3 Normal: empty
Node 3 HighMem: 1152*4kB 644*8kB 206*16kB 46*32kB 7*64kB 7*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 999*4096kB = 4109568kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap:            0kB
4162048 pages of RAM
3833856 pages of HIGHMEM
142849 reserved pages
64054 pages shared
0 pages swap cached

telnet> send break
SysRq : Show State

                                               sibling
  task             PC      pid father child younger older
init          S 005B0C6B     1      0     2               (NOTLB)
Call Trace:
 [<c01225bd>] add_timer+0x5d/0x6c
 [<c0122fe0>] schedule_timeout+0x8c/0xac
 [<c0122f48>] process_timeout+0x0/0xc
 [<c0159e29>] do_select+0x295/0x2d8
 [<c0159a54>] __pollwait+0x0/0x9c
 [<c015a1ca>] sys_select+0x336/0x470
 [<c0108c57>] syscall_call+0x7/0xb

migration/0   S EA39B960     2      1             3       (L-TLB)
Call Trace:
 [<c0119b8c>] migration_thread+0xb4/0x280
 [<c0119ad8>] migration_thread+0x0/0x280
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/0   S F0184000     3      1             4     2 (L-TLB)
Call Trace:
 [<c011f52a>] do_softirq+0x6a/0xc8
 [<c011fa21>] ksoftirqd+0x89/0xc4
 [<c011f998>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/1   S EBADCD20     4      1             5     3 (L-TLB)
Call Trace:
 [<c0119b8c>] migration_thread+0xb4/0x280
 [<c0119ad8>] migration_thread+0x0/0x280
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/1   S F0180000     5      1             6     4 (L-TLB)
Call Trace:
 [<c011f52a>] do_softirq+0x6a/0xc8
 [<c011fa21>] ksoftirqd+0x89/0xc4
 [<c011f998>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/2   S EA8566B0     6      1             7     5 (L-TLB)
Call Trace:
 [<c0119b8c>] migration_thread+0xb4/0x280
 [<c0119ad8>] migration_thread+0x0/0x280
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/2   R C3BBA000     7      1             8     6 (L-TLB)
Call Trace:
 [<c011f52a>] do_softirq+0x6a/0xc8
 [<c011fa21>] ksoftirqd+0x89/0xc4
 [<c011f998>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/3   S EE444710     8      1             9     7 (L-TLB)
Call Trace:
 [<c0119b8c>] migration_thread+0xb4/0x280
 [<c0119ad8>] migration_thread+0x0/0x280
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/3   S C3BB6000     9      1            10     8 (L-TLB)
Call Trace:
 [<c011f52a>] do_softirq+0x6a/0xc8
 [<c011fa21>] ksoftirqd+0x89/0xc4
 [<c011f998>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/4   S EAACE6D0    10      1            11     9 (L-TLB)
Call Trace:
 [<c0119b8c>] migration_thread+0xb4/0x280
 [<c0119ad8>] migration_thread+0x0/0x280
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/4   S C3BA4000    11      1            12    10 (L-TLB)
Call Trace:
 [<c011f52a>] do_softirq+0x6a/0xc8
 [<c011fa21>] ksoftirqd+0x89/0xc4
 [<c011f998>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/5   S EA5EC690    12      1            13    11 (L-TLB)
Call Trace:
 [<c0119b8c>] migration_thread+0xb4/0x280
 [<c0119ad8>] migration_thread+0x0/0x280
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/5   S C3BFE000    13      1            14    12 (L-TLB)
Call Trace:
 [<c011f52a>] do_softirq+0x6a/0xc8
 [<c011fa21>] ksoftirqd+0x89/0xc4
 [<c011f998>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/6   S EAACE6D0    14      1            15    13 (L-TLB)
Call Trace:
 [<c0119b8c>] migration_thread+0xb4/0x280
 [<c0119ad8>] migration_thread+0x0/0x280
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/6   S C3BFA000    15      1            16    14 (L-TLB)
Call Trace:
 [<c011f52a>] do_softirq+0x6a/0xc8
 [<c011fa21>] ksoftirqd+0x89/0xc4
 [<c011f998>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/7   S EA8D20A0    16      1            17    15 (L-TLB)
Call Trace:
 [<c0119b8c>] migration_thread+0xb4/0x280
 [<c0119ad8>] migration_thread+0x0/0x280
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/7   S C3BF4000    17      1            18    16 (L-TLB)
Call Trace:
 [<c011f52a>] do_softirq+0x6a/0xc8
 [<c011fa21>] ksoftirqd+0x89/0xc4
 [<c011f998>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/8   S EA8D3960    18      1            19    17 (L-TLB)
Call Trace:
 [<c0119b8c>] migration_thread+0xb4/0x280
 [<c0119ad8>] migration_thread+0x0/0x280
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/8   S C3BE0000    19      1            20    18 (L-TLB)
Call Trace:
 [<c011f52a>] do_softirq+0x6a/0xc8
 [<c011fa21>] ksoftirqd+0x89/0xc4
 [<c011f998>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/9   S EA9212F0    20      1            21    19 (L-TLB)
Call Trace:
 [<c0119b8c>] migration_thread+0xb4/0x280
 [<c0119ad8>] migration_thread+0x0/0x280
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/9   S C3BDC000    21      1            22    20 (L-TLB)
Call Trace:
 [<c011f52a>] do_softirq+0x6a/0xc8
 [<c011fa21>] ksoftirqd+0x89/0xc4
 [<c011f998>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/10  S ECD54080    22      1            23    21 (L-TLB)
Call Trace:
 [<c0119b8c>] migration_thread+0xb4/0x280
 [<c0119ad8>] migration_thread+0x0/0x280
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/10  S C3BD6000    23      1            24    22 (L-TLB)
Call Trace:
 [<c011f52a>] do_softirq+0x6a/0xc8
 [<c011fa21>] ksoftirqd+0x89/0xc4
 [<c011f998>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/11  S EEDD2040    24      1            25    23 (L-TLB)
Call Trace:
 [<c0119b8c>] migration_thread+0xb4/0x280
 [<c0119ad8>] migration_thread+0x0/0x280
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/11  S C3BD2000    25      1            26    24 (L-TLB)
Call Trace:
 [<c011f52a>] do_softirq+0x6a/0xc8
 [<c011fa21>] ksoftirqd+0x89/0xc4
 [<c011f998>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/12  S EA5EC690    26      1            27    25 (L-TLB)
Call Trace:
 [<c0119b8c>] migration_thread+0xb4/0x280
 [<c0119ad8>] migration_thread+0x0/0x280
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/12  S F017C000    27      1            28    26 (L-TLB)
Call Trace:
 [<c011f52a>] do_softirq+0x6a/0xc8
 [<c011fa21>] ksoftirqd+0x89/0xc4
 [<c011f998>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/13  S EB8FB980    28      1            29    27 (L-TLB)
Call Trace:
 [<c0119b8c>] migration_thread+0xb4/0x280
 [<c0119ad8>] migration_thread+0x0/0x280
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/13  S F0178000    29      1            30    28 (L-TLB)
Call Trace:
 [<c011f52a>] do_softirq+0x6a/0xc8
 [<c011fa21>] ksoftirqd+0x89/0xc4
 [<c011f998>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/14  S EA0746B0    30      1            31    29 (L-TLB)
Call Trace:
 [<c0119b8c>] migration_thread+0xb4/0x280
 [<c0119ad8>] migration_thread+0x0/0x280
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/14  R F0174000    31      1            32    30 (L-TLB)
Call Trace:
 [<c011f52a>] do_softirq+0x6a/0xc8
 [<c011fa21>] ksoftirqd+0x89/0xc4
 [<c011f998>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/15  S EB3980E0    32      1            33    31 (L-TLB)
Call Trace:
 [<c0119b8c>] migration_thread+0xb4/0x280
 [<c0119ad8>] migration_thread+0x0/0x280
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/15  S F016E000    33      1            34    32 (L-TLB)
Call Trace:
 [<c011f52a>] do_softirq+0x6a/0xc8
 [<c011fa21>] ksoftirqd+0x89/0xc4
 [<c011f998>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/0      S F01D7000    34      1            35    33 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c01a8360>] batch_entropy_process+0x0/0xc0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/1      S F01D7060    35      1            36    34 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c01285f4>] __call_usermodehelper+0x0/0x50
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/2      R F01D70C0    36      1            37    35 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c01a8360>] batch_entropy_process+0x0/0xc0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/3      S F01D7120    37      1            38    36 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c01a3864>] flush_to_ldisc+0x0/0xc8
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/4      S F01D7180    38      1            39    37 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c01285f4>] __call_usermodehelper+0x0/0x50
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/5      S F01D71F4    39      1            40    38 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/6      S F01D7240    40      1            41    39 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c01285f4>] __call_usermodehelper+0x0/0x50
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/7      S F01D72B4    41      1            42    40 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/8      S F01D7314    42      1            43    41 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/9      S F01D7374    43      1            44    42 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/10     S F01D73D4    44      1            45    43 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/11     S F01D7434    45      1            46    44 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/12     S F01D7494    46      1            47    45 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/13     S F01D74F4    47      1            48    46 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/14     S F01D7554    48      1            49    47 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/15     S F01D75B4    49      1            50    48 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/0     S F00D1000    50      1            51    49 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c01c381c>] as_work_handler+0x0/0x44
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/1     S F00D1060    51      1            52    50 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c01c381c>] as_work_handler+0x0/0x44
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/2     S F00D10C0    52      1            53    51 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c01bce70>] blk_unplug_work+0x0/0x14
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/3     S F00D1120    53      1            54    52 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c01bce70>] blk_unplug_work+0x0/0x14
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/4     S F00D1180    54      1            55    53 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c01bce70>] blk_unplug_work+0x0/0x14
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/5     S F00D11E0    55      1            56    54 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c01bce70>] blk_unplug_work+0x0/0x14
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/6     S F00D1240    56      1            57    55 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c01bce70>] blk_unplug_work+0x0/0x14
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/7     S F00D12A0    57      1            58    56 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c01bce70>] blk_unplug_work+0x0/0x14
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/8     S F00D1300    58      1            59    57 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c01bce70>] blk_unplug_work+0x0/0x14
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/9     S F00D1360    59      1            60    58 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c01bce70>] blk_unplug_work+0x0/0x14
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/10    S F00D13C0    60      1            61    59 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c01bce70>] blk_unplug_work+0x0/0x14
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/11    S F00D1420    61      1            62    60 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c01bce70>] blk_unplug_work+0x0/0x14
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/12    S F00D1480    62      1            63    61 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c01bce70>] blk_unplug_work+0x0/0x14
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/13    S F00D14E0    63      1            64    62 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c01bce70>] blk_unplug_work+0x0/0x14
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/14    S F00D1540    64      1            65    63 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c01bce70>] blk_unplug_work+0x0/0x14
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/15    S F00D15A0    65      1            71    64 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c01bce70>] blk_unplug_work+0x0/0x14
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kswapd3       S EF687F48    71      1            68    65 (L-TLB)
Call Trace:
 [<c013989a>] kswapd+0xfe/0x120
 [<c013979c>] kswapd+0x0/0x120
 [<c0108c7e>] work_resched+0x5/0x16
 [<c013979c>] kswapd+0x0/0x120
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kswapd0       S EF68DF48    68      1            70    71 (L-TLB)
Call Trace:
 [<c011d35d>] daemonize+0xb5/0xbc
 [<c013989a>] kswapd+0xfe/0x120
 [<c013979c>] kswapd+0x0/0x120
 [<c0108c7e>] work_resched+0x5/0x16
 [<c013979c>] kswapd+0x0/0x120
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kswapd2       S EF689F48    70      1            69    68 (L-TLB)
Call Trace:
 [<c013989a>] kswapd+0xfe/0x120
 [<c013979c>] kswapd+0x0/0x120
 [<c0108c7e>] work_resched+0x5/0x16
 [<c013979c>] kswapd+0x0/0x120
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kswapd1       S EF68BF48    69      1            72    70 (L-TLB)
Call Trace:
 [<c013989a>] kswapd+0xfe/0x120
 [<c013979c>] kswapd+0x0/0x120
 [<c0108c7e>] work_resched+0x5/0x16
 [<c013979c>] kswapd+0x0/0x120
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/0         S EF662014    72      1            73    69 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0108c7e>] work_resched+0x5/0x16
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/1         S EF662074    73      1            74    72 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/2         S EF6620D4    74      1            75    73 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/3         S EF662134    75      1            76    74 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/4         S EF662194    76      1            77    75 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/5         S EF6621F4    77      1            78    76 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/6         S EF662254    78      1            79    77 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/7         S EF6622B4    79      1            80    78 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/8         S EF662314    80      1            81    79 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/9         S EF662374    81      1            82    80 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/10        S EF6623D4    82      1            83    81 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/11        S EF662434    83      1            84    82 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/12        S EF662494    84      1            85    83 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/13        S EF6624F4    85      1            86    84 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/14        S EF662554    86      1            87    85 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/15        S EF6625B4    87      1            88    86 (L-TLB)
Call Trace:
 [<c0128a46>] worker_thread+0x13a/0x280
 [<c012890c>] worker_thread+0x0/0x280
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

scsi_eh_0     S EF5B5FA0    88      1            89    87 (L-TLB)
Call Trace:
 [<c0118871>] default_wake_function+0x19/0x20
 [<c0107c42>] __down_interruptible+0x9a/0x124
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d23>] __down_failed_interruptible+0x7/0xc
 [<c01cca3e>] .text.lock.scsi_error+0xbd/0xcf
 [<c01cc698>] scsi_error_handler+0x0/0x11c
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

scsi_eh_1     S EF5A3FA0    89      1            90    88 (L-TLB)
Call Trace:
 [<c0118871>] default_wake_function+0x19/0x20
 [<c0107c42>] __down_interruptible+0x9a/0x124
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d23>] __down_failed_interruptible+0x7/0xc
 [<c01cca3e>] .text.lock.scsi_error+0xbd/0xcf
 [<c01cc698>] scsi_error_handler+0x0/0x11c
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

scsi_eh_2     S EF5A1FA0    90      1            91    89 (L-TLB)
Call Trace:
 [<c0118871>] default_wake_function+0x19/0x20
 [<c0107c42>] __down_interruptible+0x9a/0x124
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d23>] __down_failed_interruptible+0x7/0xc
 [<c01cca3e>] .text.lock.scsi_error+0xbd/0xcf
 [<c01cc698>] scsi_error_handler+0x0/0x11c
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

scsi_eh_3     S EF59FFA0    91      1           164    90 (L-TLB)
Call Trace:
 [<c0118871>] default_wake_function+0x19/0x20
 [<c0107c42>] __down_interruptible+0x9a/0x124
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d23>] __down_failed_interruptible+0x7/0xc
 [<c01cca3e>] .text.lock.scsi_error+0xbd/0xcf
 [<c01cc698>] scsi_error_handler+0x0/0x11c
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kjournald     S 00000001   164      1           191    91 (L-TLB)
Call Trace:
 [<c01897cb>] kjournald+0x1ab/0x230
 [<c0189620>] kjournald+0x0/0x230
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c0189610>] commit_timeout+0x0/0xc
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

portmap       S EEB15F68   191      1           255   164 (NOTLB)
Call Trace:
 [<c01e68f9>] sock_poll+0x1d/0x24
 [<c0122f68>] schedule_timeout+0x14/0xac
 [<c015a3ef>] do_poll+0x67/0xc8
 [<c015a431>] do_poll+0xa9/0xc8
 [<c015a58e>] sys_poll+0x13e/0x1e1
 [<c0159a54>] __pollwait+0x0/0x9c
 [<c0108c57>] syscall_call+0x7/0xb

syslogd       R 00000304   255      1           258   191 (NOTLB)
Call Trace:
 [<c0159ae8>] __pollwait+0x94/0x9c
 [<c0122f68>] schedule_timeout+0x14/0xac
 [<c01e68f9>] sock_poll+0x1d/0x24
 [<c0159d44>] do_select+0x1b0/0x2d8
 [<c0159e29>] do_select+0x295/0x2d8
 [<c0159a54>] __pollwait+0x0/0x9c
 [<c015a1ca>] sys_select+0x336/0x470
 [<c0108c57>] syscall_call+0x7/0xb

klogd         S EEB4FDFC   258      1           267   255 (NOTLB)
Call Trace:
 [<c0122f68>] schedule_timeout+0x14/0xac
 [<c01e8af7>] sock_alloc_send_pskb+0x73/0x234
 [<c022cbc0>] unix_wait_for_peer+0x94/0xb4
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c022d60a>] unix_dgram_sendmsg+0x38a/0x498
 [<c01e6463>] sock_aio_write+0xcb/0xd4
 [<c0149418>] do_sync_write+0xac/0xe0
 [<c0118791>] schedule+0x401/0x4c8
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0173465>] kmsg_read+0x11/0x18
 [<c01494fd>] vfs_write+0xb1/0xd0
 [<c0149599>] sys_write+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

inetd         S 00000000   267      1           271   258 (NOTLB)
Call Trace:
 [<c0200a25>] tcp_poll+0x2d/0x154
 [<c0122f68>] schedule_timeout+0x14/0xac
 [<c01e68f9>] sock_poll+0x1d/0x24
 [<c0159d44>] do_select+0x1b0/0x2d8
 [<c0159e29>] do_select+0x295/0x2d8
 [<c0159a54>] __pollwait+0x0/0x9c
 [<c015a1ca>] sys_select+0x336/0x470
 [<c0108c57>] syscall_call+0x7/0xb

lpd           S 00000000   271      1           285   267 (NOTLB)
Call Trace:
 [<c0200a25>] tcp_poll+0x2d/0x154
 [<c0122f68>] schedule_timeout+0x14/0xac
 [<c01e68f9>] sock_poll+0x1d/0x24
 [<c0159d44>] do_select+0x1b0/0x2d8
 [<c0159e29>] do_select+0x295/0x2d8
 [<c0159a54>] __pollwait+0x0/0x9c
 [<c015a1ca>] sys_select+0x336/0x470
 [<c01e7a57>] sys_socketcall+0xb7/0x218
 [<c0108c57>] syscall_call+0x7/0xb

sshd          S 00000000   285      1   319     288   271 (NOTLB)
Call Trace:
 [<c0200a25>] tcp_poll+0x2d/0x154
 [<c0122f68>] schedule_timeout+0x14/0xac
 [<c0132afa>] __free_pages_ok+0xbe/0xc8
 [<c01e68f9>] sock_poll+0x1d/0x24
 [<c0159d44>] do_select+0x1b0/0x2d8
 [<c0159e29>] do_select+0x295/0x2d8
 [<c0159a54>] __pollwait+0x0/0x9c
 [<c015a1ca>] sys_select+0x336/0x470
 [<c0108c57>] syscall_call+0x7/0xb

rpc.statd     S 00000000   288      1           293   285 (NOTLB)
Call Trace:
 [<c0200a25>] tcp_poll+0x2d/0x154
 [<c0122f68>] schedule_timeout+0x14/0xac
 [<c01e68f9>] sock_poll+0x1d/0x24
 [<c0159d44>] do_select+0x1b0/0x2d8
 [<c0159e29>] do_select+0x295/0x2d8
 [<c0159a54>] __pollwait+0x0/0x9c
 [<c015a1ca>] sys_select+0x336/0x470
 [<c0148c4c>] filp_close+0xa0/0xac
 [<c0108c57>] syscall_call+0x7/0xb

wu-ftpd       S EEAD0000   293      1           296   288 (NOTLB)
Call Trace:
 [<c0122f68>] schedule_timeout+0x14/0xac
 [<c02052f0>] wait_for_connect+0xe0/0x170
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c0205404>] tcp_accept+0x84/0x19c
 [<c0220ad7>] inet_accept+0x2f/0x144
 [<c01e700e>] sys_accept+0x6e/0xfc
 [<c011618f>] do_page_fault+0x11f/0x468
 [<c0116070>] do_page_fault+0x0/0x468
 [<c0200f28>] tcp_listen_start+0x190/0x1e8
 [<c0122b36>] update_wall_time+0xe/0x38
 [<c0122dff>] do_timer+0x2b/0xa0
 [<c010ec66>] timer_interrupt+0x6e/0x120
 [<c01e7a6c>] sys_socketcall+0xcc/0x218
 [<c0108c57>] syscall_call+0x7/0xb

atd           S 0036F0A4   296      1           299   293 (NOTLB)
Call Trace:
 [<c01225bd>] add_timer+0x5d/0x6c
 [<c012b8c7>] do_clock_nanosleep+0x197/0x2cc
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c012b588>] nanosleep_wake_up+0x0/0xc
 [<c012b60a>] sys_nanosleep+0x62/0xb4
 [<c0108c57>] syscall_call+0x7/0xb

cron          S 0000EA6A   299      1 13857     302   296 (NOTLB)
Call Trace:
 [<c01225bd>] add_timer+0x5d/0x6c
 [<c012b8c7>] do_clock_nanosleep+0x197/0x2cc
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c012b588>] nanosleep_wake_up+0x0/0xc
 [<c012b60a>] sys_nanosleep+0x62/0xb4
 [<c0108c57>] syscall_call+0x7/0xb

getty         S 00000001   302      1           303   299 (NOTLB)
Call Trace:
 [<c0122f68>] schedule_timeout+0x14/0xac
 [<c01b2967>] con_flush_chars+0x33/0x34
 [<c01b281f>] con_write+0x23/0x2c
 [<c01a63c7>] read_chan+0x3b7/0x884
 [<c01a6418>] read_chan+0x408/0x884
 [<c01a6a94>] write_chan+0x200/0x220
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c01a17ac>] tty_read+0xd8/0x134
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

getty         S 00000001   303      1           304   302 (NOTLB)
Call Trace:
 [<c01b226c>] do_con_write+0x61c/0x680
 [<c0122f68>] schedule_timeout+0x14/0xac
 [<c01b2967>] con_flush_chars+0x33/0x34
 [<c01b281f>] con_write+0x23/0x2c
 [<c01a63c7>] read_chan+0x3b7/0x884
 [<c01a6418>] read_chan+0x408/0x884
 [<c01a6a94>] write_chan+0x200/0x220
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c01a17ac>] tty_read+0xd8/0x134
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

getty         S 00000001   304      1           305   303 (NOTLB)
Call Trace:
 [<c01b226c>] do_con_write+0x61c/0x680
 [<c0122f68>] schedule_timeout+0x14/0xac
 [<c01b2967>] con_flush_chars+0x33/0x34
 [<c01b281f>] con_write+0x23/0x2c
 [<c01a63c7>] read_chan+0x3b7/0x884
 [<c01a6418>] read_chan+0x408/0x884
 [<c01a6a94>] write_chan+0x200/0x220
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c01a17ac>] tty_read+0xd8/0x134
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

getty         S 00000001   305      1           306   304 (NOTLB)
Call Trace:
 [<c01b226c>] do_con_write+0x61c/0x680
 [<c0122f68>] schedule_timeout+0x14/0xac
 [<c01b2967>] con_flush_chars+0x33/0x34
 [<c01b281f>] con_write+0x23/0x2c
 [<c01a63c7>] read_chan+0x3b7/0x884
 [<c01a6418>] read_chan+0x408/0x884
 [<c01a6a94>] write_chan+0x200/0x220
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c01a17ac>] tty_read+0xd8/0x134
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

getty         S 00000001   306      1           307   305 (NOTLB)
Call Trace:
 [<c01b226c>] do_con_write+0x61c/0x680
 [<c0122f68>] schedule_timeout+0x14/0xac
 [<c01b2967>] con_flush_chars+0x33/0x34
 [<c01b281f>] con_write+0x23/0x2c
 [<c01a63c7>] read_chan+0x3b7/0x884
 [<c01a6418>] read_chan+0x408/0x884
 [<c01a6a94>] write_chan+0x200/0x220
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c01a17ac>] tty_read+0xd8/0x134
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

getty         S 00000001   307      1           308   306 (NOTLB)
Call Trace:
 [<c01b226c>] do_con_write+0x61c/0x680
 [<c0122f68>] schedule_timeout+0x14/0xac
 [<c01b2967>] con_flush_chars+0x33/0x34
 [<c01b281f>] con_write+0x23/0x2c
 [<c01a63c7>] read_chan+0x3b7/0x884
 [<c01a6418>] read_chan+0x408/0x884
 [<c01a6a94>] write_chan+0x200/0x220
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c01a17ac>] tty_read+0xd8/0x134
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

getty         S 00000001   308      1         13633   307 (NOTLB)
Call Trace:
 [<c01b3abd>] uart_start+0x21/0x2c
 [<c0122f68>] schedule_timeout+0x14/0xac
 [<c01a63c7>] read_chan+0x3b7/0x884
 [<c01a6418>] read_chan+0x408/0x884
 [<c01a6a94>] write_chan+0x200/0x220
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c01a17ac>] tty_read+0xd8/0x134
 [<c011f7a3>] tasklet_action+0x7b/0xd8
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

sshd          S 00000104   319    285   321               (NOTLB)
Call Trace:
 [<c01a7a49>] pty_chars_in_buffer+0x1d/0x44
 [<c0122f68>] schedule_timeout+0x14/0xac
 [<c01a2b60>] tty_poll+0x84/0x90
 [<c0159d44>] do_select+0x1b0/0x2d8
 [<c0159e29>] do_select+0x295/0x2d8
 [<c0159a54>] __pollwait+0x0/0x9c
 [<c015a1ca>] sys_select+0x336/0x470
 [<c0108c57>] syscall_call+0x7/0xb

bash          S EEC4F9BC   321    319   323               (NOTLB)
Call Trace:
 [<c011cf6a>] session_of_pgrp+0x26/0x84
 [<c01a30e7>] tiocspgrp+0x6f/0x94
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c012558c>] sys_rt_sigprocmask+0x118/0x130
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

stessdet      S EEDE417C   323    321 24530               (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sdetbench     S EEDE47AC 24530    323 31939               (NOTLB)
Call Trace:
 [<c0125f06>] do_sigaction+0x1d6/0x240
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

pdflush       S EDD07FE4 13633      1         15152   308 (L-TLB)
Call Trace:
 [<c0134ab9>] start_one_pdflush_thread+0x11/0x15
 [<c01348f1>] __pdflush+0x91/0x1a8
 [<c0134a08>] pdflush+0x0/0x14
 [<c0134a13>] pdflush+0xb/0x14
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

pdflush       S EAC1FFE4 15152      1               13633 (L-TLB)
Call Trace:
 [<c01348f1>] __pdflush+0x91/0x1a8
 [<c0134a08>] pdflush+0x0/0x14
 [<c0134a13>] pdflush+0xb/0x14
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

sh            S EBA9ED3C 31939  24530 31940               (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

spec_auto     S EC64C74C 31940  31939 31952               (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

make          S EDCD6DBC 31952  31940 31954   31953       (NOTLB)
Call Trace:
 [<c010fde1>] restore_i387_fxsave+0x55/0x64
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

tee           S EDA0C7D0 31953  31940               31952 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013007b>] do_generic_mapping_read+0x2f7/0x390
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

benchrun      S EC44213C 31954  31952 31959               (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

benchrun      S EC97C15C 31959  31954 31964               (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

make          S EA883A1C 31964  31959 32269   31965       (NOTLB)
Call Trace:
 [<c010fde1>] restore_i387_fxsave+0x55/0x64
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

tee           S EA628E90 31965  31959               31964 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EB99276C 32269  31964 32274               (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

time          S EBADC15C 32274  32269 32275               (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

time          S EAD9936C 32275  32274 32276               (NOTLB)
Call Trace:
 [<c0125f06>] do_sigaction+0x1d6/0x240
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

run.sdet      S EC8D217C 32276  32275 32281               (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

run           S EBAD272C 32281  32276 32283               (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

driver        S EC8D3A3C 32283  32281 32284               (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

driver.exec   S EC8D27AC 32284  32283 32287               (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EA5E99BC 32287  32284 11018   32289       (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EBAD20FC 32289  32284 12689   32293 32287 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S ED4619BC 32293  32284 11693   32295 32289 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EB99213C 32295  32284 12678   32302 32293 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EC6839FC 32302  32284  7115   32313 32295 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EA8833EC 32313  32284 12075   32315 32302 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EBA9E70C 32315  32284  9086   32316 32313 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EBA9F36C 32316  32284 11006   32326 32315 (NOTLB)
Call Trace:
 [<c011a1f7>] add_wait_queue+0x2f/0x34
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EA05F9FC 32326  32284 10320   32332 32316 (NOTLB)
Call Trace:
 [<c011a26c>] remove_wait_queue+0x3c/0x40
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EA88215C 32332  32284 10510   32337 32326 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EC64D9DC 32337  32284  8212   32338 32332 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EC64CD7C 32338  32284  8543   32339 32337 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EB71B9DC 32339  32284 11619   32342 32338 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EB71AD7C 32342  32284  9440   32344 32339 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EF59CD9C 32344  32284 11683   32347 32342 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EA15C17C 32347  32284  7659   32348 32344 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EA47CD5C 32348  32284  9941   32350 32347 (NOTLB)
Call Trace:
 [<c011e142>] eligible_child+0x92/0xa8
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EC444D3C 32350  32284  9940   32352 32348 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EA8340FC 32352  32284  9928   32355 32350 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EA8359BC 32355  32284  9261   32361 32352 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EC1E33CC 32361  32284 10380   32363 32355 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EB05815C 32363  32284 13730   32364 32361 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EB0593EC 32364  32284  8226   32366 32363 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EA796D7C 32366  32284  9947   32367 32364 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EA79611C 32367  32284 10622   32368 32366 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EA79674C 32368  32284  9368   32371 32367 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EDCD7A1C 32371  32284  9882   32374 32368 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EDCD73EC 32374  32284  9623   32376 32371 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S ED0A876C 32376  32284 11039   32383 32374 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EA3C27AC 32383  32284 12661   32387 32376 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EA26611C 32387  32284  8183   32389 32383 (NOTLB)
Call Trace:
 [<c011837b>] scheduler_tick+0x37b/0x388
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EA266D7C 32389  32284 11513   32391 32387 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EA26674C 32391  32284 13775   32397 32389 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EA47D9BC 32397  32284 12961   32401 32391 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EA3C3A3C 32401  32284 10878   32412 32397 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EA86F9BC 32412  32284 10339         32401 (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

make          S EA270D3C  7115  32302  9911               (NOTLB)
Call Trace:
 [<c0118858>] default_wake_function+0x0/0x20
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c01254f6>] sys_rt_sigprocmask+0x82/0x130
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

make          S EDC3617C  7659  32347  9809               (NOTLB)
Call Trace:
 [<c0118858>] default_wake_function+0x0/0x20
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c01254f6>] sys_rt_sigprocmask+0x82/0x130
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

make          S EBCBF9FC  8183  32387  9612               (NOTLB)
Call Trace:
 [<c0118858>] default_wake_function+0x0/0x20
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c01254f6>] sys_rt_sigprocmask+0x82/0x130
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246  8226  32364          8229       (NOTLB)
Call Trace:
 [<c011f52a>] do_softirq+0x6a/0xc8
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c0158433>] .text.lock.namei+0x25/0x242
 [<c015562b>] do_lookup+0x4f/0x94
 [<c0155bc7>] link_path_walk+0x557/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c01562b4>] __user_walk+0x28/0x40
 [<c0151d5d>] vfs_stat+0x19/0x48
 [<c01522f7>] sys_stat64+0x13/0x30
 [<c0108c57>] syscall_call+0x7/0xb

make          S EDC2999C  8212  32337  9825               (NOTLB)
Call Trace:
 [<c0118858>] default_wake_function+0x0/0x20
 [<c011e668>] sys_wait4+0x20c/0x244
 [<c01254f6>] sys_rt_sigprocmask+0x82/0x130
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EBF360D0  8229  32364                8226 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246  8543  32338          8546       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c0158433>] .text.lock.namei+0x25/0x242
 [<c015562b>] do_lookup+0x4f/0x94
 [<c01558b9>] link_path_walk+0x249/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c0156661>] open_namei+0x89/0x3b0
 [<c011837b>] scheduler_tick+0x37b/0x388
 [<c01487b3>] filp_open+0x3b/0x5c
 [<c0148b57>] sys_open+0x37/0x74
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EC51E530  8546  32338                8543 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246  9086  32315          9181       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c01599dd>] .text.lock.readdir+0x5/0x18
 [<c015998f>] sys_getdents64+0x67/0xb0
 [<c015981c>] filldir64+0x0/0x10c
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EDA16530  9181  32315                9086 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246  9261  32355          9262       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c0158433>] .text.lock.namei+0x25/0x242
 [<c015562b>] do_lookup+0x4f/0x94
 [<c0155bc7>] link_path_walk+0x557/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c01562b4>] __user_walk+0x28/0x40
 [<c0151d5d>] vfs_stat+0x19/0x48
 [<c01522f7>] sys_stat64+0x13/0x30
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EA06DE90  9262  32355                9261 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246  9368  32368          9370       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c0158433>] .text.lock.namei+0x25/0x242
 [<c015562b>] do_lookup+0x4f/0x94
 [<c0155bc7>] link_path_walk+0x557/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c01562b4>] __user_walk+0x28/0x40
 [<c0151d5d>] vfs_stat+0x19/0x48
 [<c01522f7>] sys_stat64+0x13/0x30
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EAA9CC30  9370  32368                9368 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

ps            R 3EDE4083  9440  32342          9443       (NOTLB)
Call Trace:
 [<c0109646>] apic_timer_interrupt+0x1a/0x20
 [<c0171d91>] .text.lock.base+0x1f5/0x214
 [<c0170155>] proc_root_lookup+0x85/0x98
 [<c01553ec>] real_lookup+0x54/0xc4
 [<c015562b>] do_lookup+0x4f/0x94
 [<c0155bc7>] link_path_walk+0x557/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c01562b4>] __user_walk+0x28/0x40
 [<c0151d5d>] vfs_stat+0x19/0x48
 [<c01522f7>] sys_stat64+0x13/0x30
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EA628BD0  9443  32342                9440 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

cc            D ED0E9F74  9612   8183  9837               (NOTLB)
Call Trace:
 [<c0118a36>] wait_for_completion+0x7e/0xc0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c011b887>] do_fork+0x11b/0x154
 [<c01076c3>] sys_vfork+0x1b/0x24
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246  9623  32374          9665       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c01599dd>] .text.lock.readdir+0x5/0x18
 [<c015998f>] sys_getdents64+0x67/0xb0
 [<c015981c>] filldir64+0x0/0x10c
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EDA16270  9665  32374                9623 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

cc            R BFFFFBE0  9809   7659  9879               (NOTLB)
Call Trace:
 [<c0109646>] apic_timer_interrupt+0x1a/0x20
 [<c011e6c3>] .text.lock.exit+0x9/0x1b6
 [<c011e29a>] wait_task_zombie+0x142/0x164
 [<c011e586>] sys_wait4+0x12a/0x244
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0108c57>] syscall_call+0x7/0xb

cc            D EE127F74  9825   8212  9905               (NOTLB)
Call Trace:
 [<c0118a36>] wait_for_completion+0x7e/0xc0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c011b887>] do_fork+0x11b/0x154
 [<c01076c3>] sys_vfork+0x1b/0x24
 [<c0108c57>] syscall_call+0x7/0xb

cc            R ED8F5DDC  9837   9612                     (NOTLB)
Call Trace:
 [<c0118a36>] wait_for_completion+0x7e/0xc0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0119acf>] set_cpus_allowed+0xef/0xf8
 [<c0117929>] sched_migrate_task+0x21/0x34
 [<c01179f1>] sched_balance_exec+0x2d/0x34
 [<c0153a81>] do_execve+0x1d/0x20c
 [<c012fa35>] find_get_page+0x1d/0x30
 [<c01307f8>] filemap_nopage+0xe8/0x2ac
 [<c0130829>] filemap_nopage+0x119/0x2ac
 [<c013d122>] do_no_page+0x28e/0x300
 [<c013d30f>] handle_mm_fault+0xc7/0x190
 [<c011618f>] do_page_fault+0x11f/0x468
 [<c0116070>] do_page_fault+0x0/0x468
 [<c015d685>] dput+0x19/0x188
 [<c0148c4c>] filp_close+0xa0/0xac
 [<c015510d>] getname+0x5d/0x9c
 [<c01076fb>] sys_execve+0x2f/0x6c
 [<c0108c57>] syscall_call+0x7/0xb

cpp0          W EC2F6710  9879   9809                     (L-TLB)
Call Trace:
 [<c011df78>] do_exit+0x32c/0x338
 [<c011dfaa>] sys_exit+0xe/0x10
 [<c0108c57>] syscall_call+0x7/0xb

sh            R E9F27DDC  9882  32371                     (NOTLB)
Call Trace:
 [<c0118a36>] wait_for_completion+0x7e/0xc0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0119acf>] set_cpus_allowed+0xef/0xf8
 [<c0117929>] sched_migrate_task+0x21/0x34
 [<c01179f1>] sched_balance_exec+0x2d/0x34
 [<c0153a81>] do_execve+0x1d/0x20c
 [<c0132f4f>] __alloc_pages+0x87/0x318
 [<c01331d2>] __alloc_pages+0x30a/0x318
 [<c0138261>] invalidate_vcache+0x19/0x6d
 [<c013c5a6>] do_wp_page+0x38e/0x3a4
 [<c013d386>] handle_mm_fault+0x13e/0x190
 [<c011618f>] do_page_fault+0x11f/0x468
 [<c0116070>] do_page_fault+0x0/0x468
 [<c015d685>] dput+0x19/0x188
 [<c0125e96>] do_sigaction+0x166/0x240
 [<c0125f06>] do_sigaction+0x1d6/0x240
 [<c0126296>] sys_rt_sigaction+0xae/0xd4
 [<c015510d>] getname+0x5d/0x9c
 [<c01076fb>] sys_execve+0x2f/0x6c
 [<c0108c57>] syscall_call+0x7/0xb

cc            R EAEF7DDC  9905   9825                     (NOTLB)
Call Trace:
 [<c0118a36>] wait_for_completion+0x7e/0xc0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0119acf>] set_cpus_allowed+0xef/0xf8
 [<c0117929>] sched_migrate_task+0x21/0x34
 [<c01179f1>] sched_balance_exec+0x2d/0x34
 [<c0153a81>] do_execve+0x1d/0x20c
 [<c012fa35>] find_get_page+0x1d/0x30
 [<c01307f8>] filemap_nopage+0xe8/0x2ac
 [<c0130829>] filemap_nopage+0x119/0x2ac
 [<c013d186>] do_no_page+0x2f2/0x300
 [<c013d30f>] handle_mm_fault+0xc7/0x190
 [<c011618f>] do_page_fault+0x11f/0x468
 [<c0116070>] do_page_fault+0x0/0x468
 [<c015d685>] dput+0x19/0x188
 [<c0148c4c>] filp_close+0xa0/0xac
 [<c015510d>] getname+0x5d/0x9c
 [<c01076fb>] sys_execve+0x2f/0x6c
 [<c0108c57>] syscall_call+0x7/0xb

cc            D E9C9BF74  9911   7115  9914               (NOTLB)
Call Trace:
 [<c0118a36>] wait_for_completion+0x7e/0xc0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c011b887>] do_fork+0x11b/0x154
 [<c01076c3>] sys_vfork+0x1b/0x24
 [<c0108c57>] syscall_call+0x7/0xb

cc            R EB20BDDC  9914   9911                     (NOTLB)
Call Trace:
 [<c0118a36>] wait_for_completion+0x7e/0xc0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0119acf>] set_cpus_allowed+0xef/0xf8
 [<c0117929>] sched_migrate_task+0x21/0x34
 [<c01179f1>] sched_balance_exec+0x2d/0x34
 [<c0153a81>] do_execve+0x1d/0x20c
 [<c0118871>] default_wake_function+0x19/0x20
 [<c01188b2>] __wake_up_common+0x3a/0x54
 [<c015d685>] dput+0x19/0x188
 [<c0148c4c>] filp_close+0xa0/0xac
 [<c015510d>] getname+0x5d/0x9c
 [<c01076fb>] sys_execve+0x2f/0x6c
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246  9928  32352          9930       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c0158433>] .text.lock.namei+0x25/0x242
 [<c015562b>] do_lookup+0x4f/0x94
 [<c0155bc7>] link_path_walk+0x557/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c0156661>] open_namei+0x89/0x3b0
 [<c01487b3>] filp_open+0x3b/0x5c
 [<c0148b57>] sys_open+0x37/0x74
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EA269AB0  9930  32352                9928 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246  9940  32350          9945       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c01599dd>] .text.lock.readdir+0x5/0x18
 [<c015998f>] sys_getdents64+0x67/0xb0
 [<c015981c>] filldir64+0x0/0x10c
 [<c0108c57>] syscall_call+0x7/0xb

sh            R EBE9DDDC  9941  32348                     (NOTLB)
Call Trace:
 [<c0113d3f>] smp_apic_timer_interrupt+0x14b/0x158
 [<c0118a36>] wait_for_completion+0x7e/0xc0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0119acf>] set_cpus_allowed+0xef/0xf8
 [<c0117929>] sched_migrate_task+0x21/0x34
 [<c01179f1>] sched_balance_exec+0x2d/0x34
 [<c0153a81>] do_execve+0x1d/0x20c
 [<c0132f4f>] __alloc_pages+0x87/0x318
 [<c01331d2>] __alloc_pages+0x30a/0x318
 [<c0138261>] invalidate_vcache+0x19/0x6d
 [<c013c5a6>] do_wp_page+0x38e/0x3a4
 [<c013d386>] handle_mm_fault+0x13e/0x190
 [<c011618f>] do_page_fault+0x11f/0x468
 [<c0116070>] do_page_fault+0x0/0x468
 [<c0113d3f>] smp_apic_timer_interrupt+0x14b/0x158
 [<c0125e96>] do_sigaction+0x166/0x240
 [<c0125f06>] do_sigaction+0x1d6/0x240
 [<c0126296>] sys_rt_sigaction+0xae/0xd4
 [<c015510d>] getname+0x5d/0x9c
 [<c01076fb>] sys_execve+0x2f/0x6c
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EDA0CBF0  9945  32350                9940 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246  9947  32366          9950       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c0158433>] .text.lock.namei+0x25/0x242
 [<c015562b>] do_lookup+0x4f/0x94
 [<c0155bc7>] link_path_walk+0x557/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c0156661>] open_namei+0x89/0x3b0
 [<c01487b3>] filp_open+0x3b/0x5c
 [<c0148b57>] sys_open+0x37/0x74
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EDA0CA90  9950  32366                9947 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246 10320  32326         10323       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c0158433>] .text.lock.namei+0x25/0x242
 [<c015562b>] do_lookup+0x4f/0x94
 [<c0155bc7>] link_path_walk+0x557/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c0156661>] open_namei+0x89/0x3b0
 [<c01487b3>] filp_open+0x3b/0x5c
 [<c0148b57>] sys_open+0x37/0x74
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EA06D390 10323  32326               10320 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246 10339  32412         10468       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c0158433>] .text.lock.namei+0x25/0x242
 [<c015562b>] do_lookup+0x4f/0x94
 [<c0155bc7>] link_path_walk+0x557/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c0156661>] open_namei+0x89/0x3b0
 [<c01487b3>] filp_open+0x3b/0x5c
 [<c0148b57>] sys_open+0x37/0x74
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246 10380  32361         10465       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c0158433>] .text.lock.namei+0x25/0x242
 [<c015562b>] do_lookup+0x4f/0x94
 [<c0155bc7>] link_path_walk+0x557/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c0156661>] open_namei+0x89/0x3b0
 [<c01487b3>] filp_open+0x3b/0x5c
 [<c0148b57>] sys_open+0x37/0x74
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EF53C250 10465  32361               10380 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EA06D910 10468  32412               10339 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246 10510  32332         10511       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c0158433>] .text.lock.namei+0x25/0x242
 [<c015562b>] do_lookup+0x4f/0x94
 [<c0155bc7>] link_path_walk+0x557/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c0156661>] open_namei+0x89/0x3b0
 [<c01487b3>] filp_open+0x3b/0x5c
 [<c0148b57>] sys_open+0x37/0x74
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EA06D7B0 10511  32332               10510 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246 10622  32367         10623       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c0158433>] .text.lock.namei+0x25/0x242
 [<c015562b>] do_lookup+0x4f/0x94
 [<c0155bc7>] link_path_walk+0x557/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c0156661>] open_namei+0x89/0x3b0
 [<c01487b3>] filp_open+0x3b/0x5c
 [<c0148b57>] sys_open+0x37/0x74
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EAC43930 10623  32367               10622 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246 10878  32401         10892       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c0158433>] .text.lock.namei+0x25/0x242
 [<c015562b>] do_lookup+0x4f/0x94
 [<c0155bc7>] link_path_walk+0x557/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c0156661>] open_namei+0x89/0x3b0
 [<c01487b3>] filp_open+0x3b/0x5c
 [<c0148b57>] sys_open+0x37/0x74
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EDA16690 10892  32401               10878 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246 11006  32316         11012       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c0158433>] .text.lock.namei+0x25/0x242
 [<c015562b>] do_lookup+0x4f/0x94
 [<c0155bc7>] link_path_walk+0x557/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c0156661>] open_namei+0x89/0x3b0
 [<c01487b3>] filp_open+0x3b/0x5c
 [<c0148b57>] sys_open+0x37/0x74
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EA84CAD0 11012  32316               11006 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246 11018  32287         11020       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c0158433>] .text.lock.namei+0x25/0x242
 [<c015562b>] do_lookup+0x4f/0x94
 [<c0155bc7>] link_path_walk+0x557/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c0156661>] open_namei+0x89/0x3b0
 [<c01487b3>] filp_open+0x3b/0x5c
 [<c0148b57>] sys_open+0x37/0x74
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EBD7E3F0 11020  32287               11018 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246 11039  32376         11043       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c0158433>] .text.lock.namei+0x25/0x242
 [<c015562b>] do_lookup+0x4f/0x94
 [<c0155bc7>] link_path_walk+0x557/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c0156661>] open_namei+0x89/0x3b0
 [<c01487b3>] filp_open+0x3b/0x5c
 [<c0148b57>] sys_open+0x37/0x74
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EDA163D0 11043  32376               11039 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246 11513  32389         11520       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c0158433>] .text.lock.namei+0x25/0x242
 [<c015562b>] do_lookup+0x4f/0x94
 [<c0155bc7>] link_path_walk+0x557/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c0156661>] open_namei+0x89/0x3b0
 [<c01487b3>] filp_open+0x3b/0x5c
 [<c0148b57>] sys_open+0x37/0x74
 [<c0108c57>] syscall_call+0x7/0xb

wc            S E9DC3ED0 11520  32389               11513 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

sh            R EC50FDDC 11619  32339                     (NOTLB)
Call Trace:
 [<c0118a36>] wait_for_completion+0x7e/0xc0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0119acf>] set_cpus_allowed+0xef/0xf8
 [<c0117929>] sched_migrate_task+0x21/0x34
 [<c01179f1>] sched_balance_exec+0x2d/0x34
 [<c0153a81>] do_execve+0x1d/0x20c
 [<c0132f4f>] __alloc_pages+0x87/0x318
 [<c01331d2>] __alloc_pages+0x30a/0x318
 [<c0138261>] invalidate_vcache+0x19/0x6d
 [<c013c5a6>] do_wp_page+0x38e/0x3a4
 [<c013d386>] handle_mm_fault+0x13e/0x190
 [<c01522cb>] cp_new_stat64+0xe3/0xfc
 [<c0152369>] sys_fstat64+0x25/0x30
 [<c015510d>] getname+0x5d/0x9c
 [<c01076fb>] sys_execve+0x2f/0x6c
 [<c0108c57>] syscall_call+0x7/0xb

sh            R ED13FDDC 11683  32344                     (NOTLB)
Call Trace:
 [<c0118a36>] wait_for_completion+0x7e/0xc0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0119acf>] set_cpus_allowed+0xef/0xf8
 [<c0117929>] sched_migrate_task+0x21/0x34
 [<c01179f1>] sched_balance_exec+0x2d/0x34
 [<c0153a81>] do_execve+0x1d/0x20c
 [<c0132f4f>] __alloc_pages+0x87/0x318
 [<c01331d2>] __alloc_pages+0x30a/0x318
 [<c0138261>] invalidate_vcache+0x19/0x6d
 [<c013c5a6>] do_wp_page+0x38e/0x3a4
 [<c013d386>] handle_mm_fault+0x13e/0x190
 [<c011618f>] do_page_fault+0x11f/0x468
 [<c0116070>] do_page_fault+0x0/0x468
 [<c015d685>] dput+0x19/0x188
 [<c011837b>] scheduler_tick+0x37b/0x388
 [<c015510d>] getname+0x5d/0x9c
 [<c01076fb>] sys_execve+0x2f/0x6c
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246 11693  32293         11695       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c0158433>] .text.lock.namei+0x25/0x242
 [<c015562b>] do_lookup+0x4f/0x94
 [<c0155bc7>] link_path_walk+0x557/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c0156661>] open_namei+0x89/0x3b0
 [<c01487b3>] filp_open+0x3b/0x5c
 [<c0148b57>] sys_open+0x37/0x74
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EAF0B7B0 11695  32293               11693 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246 12075  32313         12079       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c0158433>] .text.lock.namei+0x25/0x242
 [<c015562b>] do_lookup+0x4f/0x94
 [<c0155bc7>] link_path_walk+0x557/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c0156661>] open_namei+0x89/0x3b0
 [<c01487b3>] filp_open+0x3b/0x5c
 [<c0148b57>] sys_open+0x37/0x74
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EA269690 12079  32313               12075 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246 12661  32383         12664       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c0158433>] .text.lock.namei+0x25/0x242
 [<c015562b>] do_lookup+0x4f/0x94
 [<c0155bc7>] link_path_walk+0x557/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c0156661>] open_namei+0x89/0x3b0
 [<c01487b3>] filp_open+0x3b/0x5c
 [<c0148b57>] sys_open+0x37/0x74
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EC665A90 12664  32383               12661 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246 12678  32295         12680       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c0158433>] .text.lock.namei+0x25/0x242
 [<c015562b>] do_lookup+0x4f/0x94
 [<c0155bc7>] link_path_walk+0x557/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c0156661>] open_namei+0x89/0x3b0
 [<c01487b3>] filp_open+0x3b/0x5c
 [<c0148b57>] sys_open+0x37/0x74
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EF53C0F0 12680  32295               12678 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246 12689  32289         12690       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c0158433>] .text.lock.namei+0x25/0x242
 [<c015562b>] do_lookup+0x4f/0x94
 [<c0155bc7>] link_path_walk+0x557/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c0156661>] open_namei+0x89/0x3b0
 [<c01487b3>] filp_open+0x3b/0x5c
 [<c0148b57>] sys_open+0x37/0x74
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EBE1D690 12690  32289               12689 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246 12961  32397         12981       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c0158433>] .text.lock.namei+0x25/0x242
 [<c015562b>] do_lookup+0x4f/0x94
 [<c0155bc7>] link_path_walk+0x557/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c0156661>] open_namei+0x89/0x3b0
 [<c01487b3>] filp_open+0x3b/0x5c
 [<c0148b57>] sys_open+0x37/0x74
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EA628650 12981  32397               12961 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246 13730  32363         13733       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c0158433>] .text.lock.namei+0x25/0x242
 [<c015562b>] do_lookup+0x4f/0x94
 [<c0155bc7>] link_path_walk+0x557/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c0156661>] open_namei+0x89/0x3b0
 [<c01487b3>] filp_open+0x3b/0x5c
 [<c0148b57>] sys_open+0x37/0x74
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EC51E270 13733  32363               13730 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

ps            D 00000246 13775  32391         13779       (NOTLB)
Call Trace:
 [<c0107b32>] __down+0x7a/0xf0
 [<c0118858>] default_wake_function+0x0/0x20
 [<c0107d18>] __down_failed+0x8/0xc
 [<c0158433>] .text.lock.namei+0x25/0x242
 [<c015562b>] do_lookup+0x4f/0x94
 [<c0155bc7>] link_path_walk+0x557/0x7fc
 [<c0156191>] path_lookup+0x155/0x15c
 [<c0156661>] open_namei+0x89/0x3b0
 [<c01487b3>] filp_open+0x3b/0x5c
 [<c0148b57>] sys_open+0x37/0x74
 [<c0108c57>] syscall_call+0x7/0xb

wc            S EAB2BE90 13779  32391               13775 (NOTLB)
Call Trace:
 [<c0125124>] get_signal_to_deliver+0xac/0x304
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c013f3c0>] do_brk+0x190/0x1c0
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

cron          S EEF06270 13857    299 13858   13862       (NOTLB)
Call Trace:
 [<c013e140>] vma_link+0x54/0x74
 [<c01543f0>] pipe_wait+0x70/0x94
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c011a364>] autoremove_wake_function+0x0/0x38
 [<c01545b1>] pipe_read+0x19d/0x208
 [<c010f295>] old_mmap+0xe9/0x124
 [<c014933c>] vfs_read+0xa0/0xd0
 [<c014954d>] sys_read+0x31/0x4c
 [<c0108c57>] syscall_call+0x7/0xb

sh            S EA640D7C 13858  13857 13859               (NOTLB)
Call Trace:
 [<c011e668>] sys_wait4+0x20c/0
