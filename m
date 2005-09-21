Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbVIUV3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbVIUV3l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 17:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbVIUV3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 17:29:40 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:23687 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S964968AbVIUV3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 17:29:39 -0400
Message-ID: <4331D0B3.5010104@nortel.com>
Date: Wed, 21 Sep 2005 15:29:23 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Christopher Friesen" <cfriesen@nortel.com>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>, dipankar@in.ibm.com,
       Sonny Rao <sonny@burdell.org>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>, bharata@in.ibm.com
Subject: Re: dentry_cache using up all my zone normal memory -- also seen
 on 2.6.14-rc2
References: <433189B5.3030308@nortel.com> <43318FFA.4010706@nortel.com>	 <4331B89B.3080107@nortel.com> <20050921200758.GA25362@kevlar.burdell.org>	 <4331C9B2.5070801@nortel.com>  <20050921210019.GF4569@in.ibm.com> <1127337280.11109.48.camel@lade.trondhjem.org> <4331CFE7.4050805@nortel.com>
In-Reply-To: <4331CFE7.4050805@nortel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Sep 2005 21:29:33.0553 (UTC) FILETIME=[8F01FE10:01C5BEF3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friesen, Christopher [CAR:VC21:EXCH] wrote:
> Trond Myklebust wrote:
> 
>> ...and what is "an NFS filesystem"? v2, v3, v4, ...?
> 
> 
> I think the root filesystem is v3.  But as I mentioned, I just realized 
> the file manipulation was happening on a tmpfs filesystem.

As a data point, the LTP test does not trigger the oom killer if /tmp is 
  part of the root filesystem and not a separate tmpfs partition.

Chris
