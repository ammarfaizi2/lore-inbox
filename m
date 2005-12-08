Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVLHH2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVLHH2V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 02:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbVLHH2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 02:28:21 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:24543 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750702AbVLHH2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 02:28:20 -0500
Date: Thu, 8 Dec 2005 09:28:08 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andreas Dilger <adilger@clusterfs.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: [PATCH] ext3: return FSID for statvfs
In-Reply-To: <20051207200109.GG14509@schatzie.adilger.int>
Message-ID: <Pine.LNX.4.58.0512080855380.23394@sbz-30.cs.Helsinki.FI>
References: <1133900600.3279.7.camel@localhost> <20051207124043.GD14509@schatzie.adilger.int>
 <Pine.LNX.4.58.0512071512170.21616@sbz-30.cs.Helsinki.FI>
 <20051207200109.GG14509@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2005, Andreas Dilger wrote:
> Question - what is rule for "Signed-off-by:"?  I'm hesitant to add that if
> I haven't actually compiled+tested a fix, as I've seen too many instances
> of "obvious fix contains bug" to believe visual inspection is enough.  If
> "Signed-off-by:" simply indicates "Yes, this person approves of the change
> in principle" then that's OK by me.  Andrew, do you use the "CC" tag for
> that?

I think signed-off is only used when you either (1) change the patch or 
(2) pass it forward. I have seen people use "Acked-by:" for what you seem 
to want to do here.

FWIW, I have tested the patch with UML.

			Pekka
