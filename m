Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286325AbRL0QMM>; Thu, 27 Dec 2001 11:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286332AbRL0QMC>; Thu, 27 Dec 2001 11:12:02 -0500
Received: from fepB.post.tele.dk ([195.41.46.145]:36316 "EHLO
	fepB.post.tele.dk") by vger.kernel.org with ESMTP
	id <S286325AbRL0QLw>; Thu, 27 Dec 2001 11:11:52 -0500
Date: Thu, 27 Dec 2001 17:11:40 +0100
From: Jens Axboe <axboe@suse.de>
To: andersg@0x63.nu
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        lvm-devel@sistina.com
Subject: Re: lvm in 2.5.1
Message-ID: <20011227171140.D1730@suse.de>
In-Reply-To: <20011227084304.GA26255@h55p111.delphi.afb.lu.se> <3C2AEADB.24BEFE94@zip.com.au> <20011227122520.GA2194@h55p111.delphi.afb.lu.se> <20011227135453.GA5803@h55p111.delphi.afb.lu.se> <20011227162019.C1730@suse.de> <20011227160232.GA11106@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011227160232.GA11106@h55p111.delphi.afb.lu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27 2001, andersg@0x63.nu wrote:
> On Thu, Dec 27, 2001 at 04:20:19PM +0100, Jens Axboe wrote:
> > You are tossing out read-ahead info here, you want to use bio_rw and not
> > bio_data_dir. The former will pass back xA bits too, while bio_data_dir
> > is strictly the data direction (strangely :-)
> 
> you mean like this?

yes

-- 
Jens Axboe

