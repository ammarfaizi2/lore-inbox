Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266804AbSLJVFt>; Tue, 10 Dec 2002 16:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266805AbSLJVFt>; Tue, 10 Dec 2002 16:05:49 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:32751 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S266804AbSLJVFs>; Tue, 10 Dec 2002 16:05:48 -0500
Subject: Re: vmalloc
From: Arjan van de Ven <arjanv@redhat.com>
To: imran.badr@cavium.com
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <CNEJKAHIKPFGKOPLKCGDAEJOIEAA.imran.badr@cavium.com>
References: <CNEJKAHIKPFGKOPLKCGDAEJOIEAA.imran.badr@cavium.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Dec 2002 22:12:41 +0100
Message-Id: <1039554761.10002.31.camel@laptop.fenrus.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 22:02, Imran Badr wrote:
> 
> Hi,
> Is there any limitation on the amount of memory that can be allocated by
> using vmalloc ( like 128KB for kmalloc) ?
> 
for x86 you shouldn't count on being to get more than 64Mb of vmalloc
memory (even though most machines go upto 128Mb at least)
