Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314753AbSEGWZi>; Tue, 7 May 2002 18:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314870AbSEGWZh>; Tue, 7 May 2002 18:25:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62727 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314753AbSEGWZf>; Tue, 7 May 2002 18:25:35 -0400
Subject: Re: O(1) scheduler gives big boost to tbench 192
To: kravetz@us.ibm.com (Mike Kravetz)
Date: Tue, 7 May 2002 23:44:35 +0100 (BST)
Cc: rwhron@earthlink.net, mingo@elte.hu, gh@us.ibm.com,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, andrea@suse.de
In-Reply-To: <20020507151356.A18701@w-mikek.des.beaverton.ibm.com> from "Mike Kravetz" at May 07, 2002 03:13:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E175DhD-0000HF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BEFORE
> ------
> Pipe latency:    6.5185 microseconds
> Pipe bandwidth: 86.35 MB/sec
> 
> AFTER
> -----
> Pipe latency:     6.5723 microseconds
> Pipe bandwidth: 540.13 MB/sec
> 
> Comments?  If anyone would like to see/test the code (pretty simple
> really) let me know.

Are you doing prefetches on the pipe data in your system. Im curious if
this is an SMP cross processor pipe issue or simply cache behaviour ?
