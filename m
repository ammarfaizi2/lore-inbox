Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932708AbWB1XKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbWB1XKZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 18:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932712AbWB1XKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 18:10:25 -0500
Received: from bay104-f11.bay104.hotmail.com ([65.54.175.21]:16846 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932708AbWB1XKY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 18:10:24 -0500
Message-ID: <BAY104-F11448E157F2C47E004A12DC0F70@phx.gbl>
X-Originating-IP: [137.207.140.83]
X-Originating-Email: [kamrankarimi@hotmail.com]
In-Reply-To: <20060228223855.GC5831@elf.ucw.cz>
From: "Kamran Karimi" <kamrankarimi@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: why VM_SHM has been removed from mm.h?
Date: Tue, 28 Feb 2006 17:10:23 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 28 Feb 2006 23:10:24.0076 (UTC) FILETIME=[277E88C0:01C63CBC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

VM_SHM is used by DIPC to quickly recognise when we are dealing with a 
System V IPC segment. It has been "removed" from recent kernels (set to 0). 
Is there an easy way to find out if a segment is a Sys V shm? if not, I 
suggest we re-activate it.

-Kamran


