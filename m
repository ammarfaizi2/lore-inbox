Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262434AbSJ1MiB>; Mon, 28 Oct 2002 07:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262442AbSJ1Mh7>; Mon, 28 Oct 2002 07:37:59 -0500
Received: from pizda.ninka.net ([216.101.162.242]:2474 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262434AbSJ1Mh6>;
	Mon, 28 Oct 2002 07:37:58 -0500
Date: Mon, 28 Oct 2002 04:35:07 -0800 (PST)
Message-Id: <20021028.043507.104714061.davem@redhat.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [patch][cft] zero-copy dma cd writing and ripping
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021018155650.GJ15494@suse.de>
References: <20021018155650.GJ15494@suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This work reminds me that get_user_pages() (or it's callers)
need to be doing some flush_dcache_page()
