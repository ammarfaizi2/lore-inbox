Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbVCPSbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbVCPSbv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 13:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbVCPSbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 13:31:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47293 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262727AbVCPSbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 13:31:50 -0500
Message-ID: <42387B89.8@pobox.com>
Date: Wed, 16 Mar 2005 13:31:37 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: BK snapshots broken
References: <4238487F.5050708@didntduck.org>
In-Reply-To: <4238487F.5050708@didntduck.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> The snapshots on kernel.org are being created from the most recent tag 
> in the BK repo, which is 2.6.11.3.  That means they are missing all of 
> the changesets between the 2.6.11 and 2.6.11.3 tags, and don't apply to 
> a clean 2.6.11 tree.

This is my fault, but I won't have a chance to fix for a day or two.

The BK snapshot script finds the latest kernel version by looking at the 
BK tag.  It should probably look directly at the Makefile, I suppose.

	Jeff


