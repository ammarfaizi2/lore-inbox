Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315276AbSHGXOl>; Wed, 7 Aug 2002 19:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSHGXOk>; Wed, 7 Aug 2002 19:14:40 -0400
Received: from verein.lst.de ([212.34.181.86]:11278 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S315276AbSHGXOk>;
	Wed, 7 Aug 2002 19:14:40 -0400
Date: Thu, 8 Aug 2002 01:18:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Kurt Garloff <kurt@garloff.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] conditionally re-enable per-disk stats, convert to seq_file
Message-ID: <20020808011814.A14850@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Andries Brouwer <aebr@win.tue.nl>, Kurt Garloff <kurt@garloff.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20020807211856.GB322@win.tue.nl> <Pine.LNX.4.33L2.0208071610150.13813-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L2.0208071610150.13813-100000@dragon.pdx.osdl.net>; from rddunlap@osdl.org on Wed, Aug 07, 2002 at 04:10:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 04:10:48PM -0700, Randy.Dunlap wrote:
> | It is really ugly to stuff a lot of garbage into a file just because
> | it happens to exist already. If you want disk statistics, why not
> | put it in /proc/diskstatistics?
> 
> me too.
> 
> I'd like to see the disk stats added, but not in /proc/partitions.

Feel free to implement it.  This is the interface use by all major
vendors for ages and the -ac kernel series.  It's supported by unpatched
upstream performace tools.

I'll keept this patch around for the few poort soul complaining that
they don't get that's anymore after upgrading to the latest kernel.org
source.

