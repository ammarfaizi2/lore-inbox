Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281046AbRKOUii>; Thu, 15 Nov 2001 15:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281044AbRKOUi3>; Thu, 15 Nov 2001 15:38:29 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:31984 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281048AbRKOUiP>;
	Thu, 15 Nov 2001 15:38:15 -0500
Date: Thu, 15 Nov 2001 13:37:34 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Sven Heinicke <sven@research.nj.nec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/stat description for proc.txt
Message-ID: <20011115133734.P5739@lynx.no>
Mail-Followup-To: Sven Heinicke <sven@research.nj.nec.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <15347.57175.887835.525156@abasin.nj.nec.com> <20011115115939.I5739@lynx.no> <15348.8974.587924.655924@abasin.nj.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <15348.8974.587924.655924@abasin.nj.nec.com>; from sven@research.nj.nec.com on Thu, Nov 15, 2001 at 03:18:22PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 15, 2001  15:18 -0500, Sven Heinicke wrote:
> +total of all the separate CPU statistics.  The four numbers following
> +"cpu" entries are: user, nice, system and idle usage.  These are
> +stored in, I believe, jiffers.
They definitely are in   ^^^^^^^ units of jiffies.

> +The "btime" field the is up time of the system in seconds.

It's not the uptime, but actually the time in seconds that the system booted.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

