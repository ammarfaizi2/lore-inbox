Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263786AbUDVCzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbUDVCzQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 22:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbUDVCzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 22:55:15 -0400
Received: from hera.kernel.org ([63.209.29.2]:5592 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S263786AbUDVCzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 22:55:07 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: The missing RAID level
Date: Thu, 22 Apr 2004 02:54:51 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c67c5r$c0u$1@terminus.zytor.com>
References: <045P8FJ12@server5.heliogroup.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1082602491 12319 63.209.29.3 (22 Apr 2004 02:54:51 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 22 Apr 2004 02:54:51 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <045P8FJ12@server5.heliogroup.fr>
By author:    Hubert Tonneau <hubert.tonneau@fullpliant.org>
In newsgroup: linux.dev.kernel
> 
> So, one very interesting possibility would be to have an extra RAID level that
> would do the following:
> assuming that you connect 5+1 partitions, then you get 5 md partitions, not a
> single one, with the following properties:
> . any read to mdX goes straight forward to reading the underlying partition.
> . any write goes staight forward to writting the underlying partition, but also
>   updates the parity on the extra partition.
> 

You have just described RAID 4.

	-hpa
