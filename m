Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261468AbTCQJ0s>; Mon, 17 Mar 2003 04:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261475AbTCQJ0s>; Mon, 17 Mar 2003 04:26:48 -0500
Received: from holomorphy.com ([66.224.33.161]:28121 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261468AbTCQJ0r>;
	Mon, 17 Mar 2003 04:26:47 -0500
Date: Mon, 17 Mar 2003 01:37:12 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] distributed counters for ext2 to avoid group scaning
Message-ID: <20030317093712.GP20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alex Tomas <bzzz@tmi.comex.ru>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
References: <m3el5773to.fsf@lexa.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3el5773to.fsf@lexa.home.net>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 16, 2003 at 06:01:55PM +0300, Alex Tomas wrote:
> ext2 with concurrent balloc/ialloc doesn't maintain global free
> inodes/blocks counters. this is due to badness of spinlocks and
> atomic_t from big iron's viewpoint. therefore, to know these values
> we should scan all group descriptors.  there are 81 groups for 10G
> fs. I believe there is method to avoid scaning and decrease memory
> footprint. 

benching now


-- wli
