Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316397AbSHASXz>; Thu, 1 Aug 2002 14:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316434AbSHASXy>; Thu, 1 Aug 2002 14:23:54 -0400
Received: from stine.vestdata.no ([195.204.68.10]:34765 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S316397AbSHASXy>; Thu, 1 Aug 2002 14:23:54 -0400
Date: Thu, 1 Aug 2002 20:27:18 +0200
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: jpiszcz@lucidpixels.com, linux-kernel@vger.kernel.org, lftp@uniyar.ac.ru,
       lftp-devel@uniyar.ac.ru, apiszcz@mitre.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: Nasty ext2fs bug!
Message-ID: <20020801202718.S20768@vestdata.no>
References: <Pine.LNX.4.44.0208011150310.17729-100000@lucidpixels.com> <20020801174856.GA29562@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020801174856.GA29562@clusterfs.com>; from adilger@clusterfs.com on Thu, Aug 01, 2002 at 11:48:56AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 11:48:56AM -0600, Andreas Dilger wrote:
> >  Problem: The pget -n feature of lftp is very nice if you want to maximize
> >           your download bandwidth, however, if getting a large file, such
> >           as the one I am getting, once the file is successfully
> >           retrived, transferring it to another HDD or FTPing it to another
> >           computer is very slow (800KB-1600KB/s).
> 
> I find it hard to believe that this would actually make a huge
> difference, except in the case where the source is throttling bandwidth
> on a per-connection basis.  Either your network is saturated by the
> transfer, or some point in between is saturated.  I could be wrong, of
> course, and it would be interesting to hear the reasoning behind the
> speedup.

If some link is saturated with 1000 connections, you will get 1% of the
bandwith instead of 0.1% if you use 10 concurrent connections. right?



-- 
Ragnar Kjørstad
