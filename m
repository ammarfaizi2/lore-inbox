Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136035AbREHCji>; Mon, 7 May 2001 22:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136123AbREHCj2>; Mon, 7 May 2001 22:39:28 -0400
Received: from feeder.cyberbills.com ([64.41.210.81]:7689 "EHLO
	sjc-smtp2.cyberbills.com") by vger.kernel.org with ESMTP
	id <S136035AbREHCjR>; Mon, 7 May 2001 22:39:17 -0400
Date: Mon, 7 May 2001 19:39:10 -0700 (PDT)
From: "Sergey Kubushin" <ksi@cyberbills.com>
To: linux-kernel@vger.kernel.org
Subject: mm: critical shortage of bounce buffers
Message-ID: <Pine.LNX.4.31ksi3.0105071930590.20449-100000@nomad.cyberbills.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anybody explain what does "mm: critical shortage of bounce buffers"
mean?

I have a 2xP-III/850 system with 2Gbyte of RAM. I'm trying to run
ImageMagick on this system with quite big files (convert consumes 1+ Gbyte
of RAM). The system crushes immediately with that message in log file and a
whole screen of constantly scrolling allocation failure messages.

Should I change some kernel define to be able to use those 2 Gbytes?

It does crush even when given "mem=960M" boot option. Both 4 and 64 Gbytes
RAM configurations do crush. Work like a charm with high memory disabled.

---
Sergey Kubushin				Sr. Unix Administrator
CyberBills, Inc.			Phone:	702-567-8857
874 American Pacific Dr,		Fax:	702-567-8808
Henderson, NV 89014

