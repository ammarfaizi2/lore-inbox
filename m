Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265255AbSKVVWl>; Fri, 22 Nov 2002 16:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbSKVVWl>; Fri, 22 Nov 2002 16:22:41 -0500
Received: from pizda.ninka.net ([216.101.162.242]:7844 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265255AbSKVVWk>;
	Fri, 22 Nov 2002 16:22:40 -0500
Date: Fri, 22 Nov 2002 13:26:41 -0800 (PST)
Message-Id: <20021122.132641.64298444.davem@redhat.com>
To: wli@holomorphy.com
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [BK-2.5] [PATCH] bootmem crash fix
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021122212419.GY23425@holomorphy.com>
References: <200211222005.gAMK5t319194@hera.kernel.org>
	<20021122.131259.66318468.davem@redhat.com>
	<20021122212419.GY23425@holomorphy.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: William Lee Irwin III <wli@holomorphy.com>
   Date: Fri, 22 Nov 2002 13:24:19 -0800
   
   Would a first_pfn variable be in order?
   
Just some silly "first_possible_paddr" macro would be fine.

It would even be fine, for now, to put it in mm.h and make it this
PAGE_OFFSET expression.

I just hate these expressions that "we know" mean something.
