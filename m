Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271004AbSISKWD>; Thu, 19 Sep 2002 06:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271005AbSISKWD>; Thu, 19 Sep 2002 06:22:03 -0400
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:43274 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S271004AbSISKWC>; Thu, 19 Sep 2002 06:22:02 -0400
Date: Thu, 19 Sep 2002 11:26:59 +0100 (BST)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: "Bond, Andrew" <Andrew.Bond@hp.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux TPC-C performance aided by kernel features
In-Reply-To: <45B36A38D959B44CB032DA427A6E106402D09E36@cceexc18.americas.cpqcorp.net>
Message-ID: <Pine.LNX.4.33.0209191121340.21867-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2002, Bond, Andrew wrote:

> 2. Large memory support (16GB) - The Oracle processes used about 14GB
> of shared memory which was allocated using shmfs and managed through a
> mapping window in the Oracle process space.  Databases always love
> more memory, however in an IA-32 architecture the gains definitely
> diminish once you get past 4GB because of overhead.  Our gains going
> from 8GB to 16GB of memory in the system were in the 10% range.

What did the gains from 4 to 8GB look like?

Could going above 4GB be a performance loss on less busy systems?
#
Matthew.

