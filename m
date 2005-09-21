Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbVIUV0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbVIUV0T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 17:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbVIUV0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 17:26:18 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:63878 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S964960AbVIUV0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 17:26:17 -0400
Message-ID: <4331CFE7.4050805@nortel.com>
Date: Wed, 21 Sep 2005 15:25:59 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: dipankar@in.ibm.com, Sonny Rao <sonny@burdell.org>,
       linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
       bharata@in.ibm.com
Subject: Re: dentry_cache using up all my zone normal memory -- also seen
 on 2.6.14-rc2
References: <433189B5.3030308@nortel.com> <43318FFA.4010706@nortel.com>	 <4331B89B.3080107@nortel.com> <20050921200758.GA25362@kevlar.burdell.org>	 <4331C9B2.5070801@nortel.com>  <20050921210019.GF4569@in.ibm.com> <1127337280.11109.48.camel@lade.trondhjem.org>
In-Reply-To: <1127337280.11109.48.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Sep 2005 21:26:09.0351 (UTC) FILETIME=[154B3D70:01C5BEF3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

> ...and what is "an NFS filesystem"? v2, v3, v4, ...?

I think the root filesystem is v3.  But as I mentioned, I just realized 
the file manipulation was happening on a tmpfs filesystem.

Chris
