Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTFDRtT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 13:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263742AbTFDRtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 13:49:19 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:37895 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263737AbTFDRtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 13:49:13 -0400
Subject: Re: file write performance drop between 2.5.60 and 2.5.70
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Vladimir Saveliev <vs@namesys.com>
Cc: LKML <linux-kernel@vger.kernel.org>, reiserfs-dev@namesys.com
In-Reply-To: <200306042017.53435.vs@namesys.com>
References: <200306042017.53435.vs@namesys.com>
Content-Type: text/plain
Message-Id: <1054749758.699.5.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 04 Jun 2003 20:02:39 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-04 at 18:17, Vladimir Saveliev wrote:
> Hi
> 
> It looks like file write performance dropped somewhere between 2.5.60 and 
> 2.5.70.
> Doing
> time dd if=/dev/zero of=file bs=4096 count=60000
> 
> on a box with Xeon(TM) CPU 2.40GHz and 1gb of RAM
> I get for ext2
> 2.5.60: 	real	1.42 sys 0.77
> 2.5.70: 	real 1.73 sys 1.23
> for reiserfs
> 2.5.60: 	real 1.62 sys 1.56
> 2.5.70: 	real 1.90 sys 1.86
> 
> Any ideas of what could cause this drop?

What filesystem are you using?

