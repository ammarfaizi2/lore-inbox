Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316973AbSFWEe7>; Sun, 23 Jun 2002 00:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316974AbSFWEe6>; Sun, 23 Jun 2002 00:34:58 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:38899 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316973AbSFWEe6>; Sun, 23 Jun 2002 00:34:58 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Sat, 22 Jun 2002 22:33:10 -0600
To: "Christopher E. Brown" <cbrown@woods.net>
Cc: "Griffiths, Richard A" <richard.a.griffiths@intel.com>,
       "'Andrew Morton'" <akpm@zip.com.au>, mgross@unix-os.sc.intel.com,
       "'Jens Axboe'" <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: ext3 performance bottleneck as the number of spindles gets large
Message-ID: <20020623043310.GL22411@clusterfs.com>
Mail-Followup-To: "Christopher E. Brown" <cbrown@woods.net>,
	"Griffiths, Richard A" <richard.a.griffiths@intel.com>,
	'Andrew Morton' <akpm@zip.com.au>, mgross@unix-os.sc.intel.com,
	'Jens Axboe' <axboe@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	lse-tech@lists.sourceforge.net
References: <01BDB7EEF8D4D3119D95009027AE99951B0E63EA@fmsmsx33.fm.intel.com> <Pine.LNX.4.44.0206222119500.28630-100000@spruce.woods.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206222119500.28630-100000@spruce.woods.net>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 22, 2002  22:02 -0600, Christopher E. Brown wrote:
> On Thu, 20 Jun 2002, Griffiths, Richard A wrote:
> 
> > I should have mentioned the throughput we saw on 4 adapters 6 drives was
> > 126KB/s.  The max theoretical bus bandwith is 640MB/s.
> 
> This is *NOT* correct.  Assuming a 64bit 66Mhz PCI bus your MAX is
> 503MB/sec minus PCI overhead...

Assuming you only have a single PCI bus...

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

