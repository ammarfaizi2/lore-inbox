Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281648AbRKVUav>; Thu, 22 Nov 2001 15:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281609AbRKVUal>; Thu, 22 Nov 2001 15:30:41 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:17647 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S281648AbRKVUaW>; Thu, 22 Nov 2001 15:30:22 -0500
Date: Thu, 22 Nov 2001 20:30:00 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Joel Beach <joelbeach@optushome.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Maximum (efficient) partition sizes for various filesystem types...
Message-ID: <20011122203000.B11821@redhat.com>
In-Reply-To: <001401c170d3$ea40cc10$1e50a8c0@kinslayer> <E165lCN-00061N-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E165lCN-00061N-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Nov 19, 2001 at 09:58:43AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 19, 2001 at 09:58:43AM +0000, Alan Cox wrote:
> > For instance, the Debian guide says that, due to Ext2 efficiency, partitions
> > greater than 6-7GB shouldn't be created. Is this true for Ext3/ReiserFS.
> 
> I've run several 45-200Gb ext2 and ext3 partitions with no problem. I'm not
> sure what the origin of the Debian guide comemnt is but I've never heard
> it from an ext2 developer

The largest filesystem I use with ext3 at the moment is 40GB, and it
is 98% full and is used *constantly* (it contains my main build
trees).  I'm not sure where the 6-7GB limit idea comes from but I've
got very few filesystems smaller than that, and they are still all
ext3.

Cheers,
 Stephen
