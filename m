Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267575AbTAXLYs>; Fri, 24 Jan 2003 06:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267594AbTAXLYs>; Fri, 24 Jan 2003 06:24:48 -0500
Received: from comtv.ru ([217.10.32.4]:55775 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S267575AbTAXLYr>;
	Fri, 24 Jan 2003 06:24:47 -0500
X-Comment-To: Andrew Morton
To: Andrew Morton <akpm@digeo.com>
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.59-mm5
References: <20030123195044.47c51d39.akpm@digeo.com>
	<946253340.1043406208@[192.168.100.5]>
	<20030124031632.7e28055f.akpm@digeo.com>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 24 Jan 2003 14:23:58 +0300
In-Reply-To: <20030124031632.7e28055f.akpm@digeo.com>
Message-ID: <m3d6mmvlip.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andrew Morton (AM) writes:

 AM> But writes are completely different.  There is no dependency
 AM> between them and at any point in time we know where on-disk a lot
 AM> of writes will be placed.  We don't know that for reads, which is
 AM> why we need to twiddle thumbs until the application or filesystem
 AM> makes up its mind.


it's significant that application doesn't want to wait read completion
long and doesn't wait for write completion in most cases.



