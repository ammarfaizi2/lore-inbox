Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSHGXJm>; Wed, 7 Aug 2002 19:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315276AbSHGXJm>; Wed, 7 Aug 2002 19:09:42 -0400
Received: from air-2.osdl.org ([65.172.181.6]:14597 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S315265AbSHGXJm>;
	Wed, 7 Aug 2002 19:09:42 -0400
Date: Wed, 7 Aug 2002 16:10:48 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Kurt Garloff <kurt@garloff.de>, Christoph Hellwig <hch@lst.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] conditionally re-enable per-disk stats, convert to
 seq_file
In-Reply-To: <20020807211856.GB322@win.tue.nl>
Message-ID: <Pine.LNX.4.33L2.0208071610150.13813-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, Andries Brouwer wrote:

|
| > On Tue, Aug 06, 2002 at 04:08:48PM +0200, Christoph Hellwig wrote:
| > > This patch against 2.4.20-pre1 converts /proc/partitions to the seq_file
| > > interface as in 2.5, makes it report the sard-style extended disk
| > > statistics condititional on CONFIG_BLK_STATS and disables the gathering
| > > of those totally otherwise to not waste memory and processing power.
|
| But why in /proc/partitions ?
| Maybe /proc/partitions can go away eventually with all info available
| under driverfs or so. But for the time being, /proc/partitions is used,
| and some changes are planned to make identification of the devices
| involved easier.
| It is really ugly to stuff a lot of garbage into a file just because
| it happens to exist already. If you want disk statistics, why not
| put it in /proc/diskstatistics?

me too.

I'd like to see the disk stats added, but not in /proc/partitions.

-- 
~Randy

