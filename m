Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263313AbTA2EYr>; Tue, 28 Jan 2003 23:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbTA2EYr>; Tue, 28 Jan 2003 23:24:47 -0500
Received: from packet.digeo.com ([12.110.80.53]:3570 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263313AbTA2EYq>;
	Tue, 28 Jan 2003 23:24:46 -0500
Date: Tue, 28 Jan 2003 20:34:18 -0800
From: Andrew Morton <akpm@digeo.com>
To: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Cc: falk.hueffner@student.uni-tuebingen.de, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.59] Optimize include/asm-ARCH/page.h:get_order()
 (take 1.0)
Message-Id: <20030128203418.24436a39.akpm@digeo.com>
In-Reply-To: <15927.20631.762730.598344@milikk.co.intel.com>
References: <15927.20631.762730.598344@milikk.co.intel.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jan 2003 04:33:58.0657 (UTC) FILETIME=[A3F03F10:01C2C74F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com> wrote:
>
> 
> This patch is a reorganization and optimization of the get_order()
> function. 

Hardly anything uses get_order().  But it seems a reasonable cleanup
anyway.

I edited your patch to convert all the eight-spaces to tabs.  Please
teach your editor to use hard tabs, thanks.

