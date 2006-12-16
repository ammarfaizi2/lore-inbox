Return-Path: <linux-kernel-owner+w=401wt.eu-S1030467AbWLPAZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030467AbWLPAZD (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 19:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030464AbWLPAZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 19:25:03 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:56858 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1030456AbWLPAZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 19:25:00 -0500
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 19:25:00 EST
Date: Fri, 15 Dec 2006 16:02:21 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Nikolai Joukov <kolya@cs.sunysb.edu>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       unionfs@filer.fsl.cs.sunysb.edu, fistgen@filer.fsl.cs.sunysb.edu
Subject: Re: [ANNOUNCE] RAIF: Redundant Array of Independent Filesystems
In-Reply-To: <Pine.GSO.4.53.0612122217360.22195@compserv1>
Message-ID: <Pine.LNX.4.63.0612151556351.14988@qynat.qvtvafvgr.pbz>
References: <Pine.GSO.4.53.0612122217360.22195@compserv1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006, Nikolai Joukov wrote:

> We have designed a new stackable file system that we called RAIF:
> Redundant Array of Independent Filesystems.
>
> Similar to Unionfs, RAIF is a fan-out file system and can be mounted over
> many different disk-based, memory, network, and distributed file systems.
> RAIF can use the stable and maintained code of the other file systems and
> thus stay simple itself.  Similar to standard RAID, RAIF can replicate the
> data or store it with parity on any subset of the lower file systems.  RAIF
> has three main advantages over traditional driver-level RAID systems:

this sounds very interesting. did you see the paper on chunkfs? 
http://www.usenix.org/events/hotdep06/tech/prelim_papers/henson/henson_html/

this sounds as if it may be something that you would be able to make a 
functional equivalent to chunkfs with your raid0 mode.

David Lang
