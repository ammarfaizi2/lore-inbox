Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbVLPAwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbVLPAwR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 19:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVLPAwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 19:52:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21208 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751122AbVLPAwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 19:52:16 -0500
Date: Thu, 15 Dec 2005 19:50:56 -0500
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org, xfs-masters@oss.sgi.com, nathans@sgi.com
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051216005056.GG3419@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, arjan@infradead.org,
	xfs-masters@oss.sgi.com, nathans@sgi.com
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051215223000.GU23349@stusta.de> <20051215231538.GF3419@redhat.com> <20051216004740.GV23349@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051216004740.GV23349@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 01:47:40AM +0100, Adrian Bunk wrote:

 > > [*] Plus a few XFS ones, but that's been a lost cause wrt stack usage
 > > for a long time -- people were reporting overflows there before we
 > > enabled 4K stacks.
 > 
 > I remember someone from the XFS maintainers (Nathan?) saying they 
 > believe having solved all XFS stack issues.
 > 
 > If there are any XFS issues left, do you have a pointer to them?

The last one I saw may have been actually been more related
to the block layer problem. iirc that was a user NFS exporting
XFS on a raid1 array.

		Dave

