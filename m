Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319564AbSIHDpr>; Sat, 7 Sep 2002 23:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319566AbSIHDpr>; Sat, 7 Sep 2002 23:45:47 -0400
Received: from CPE00606767ed59.cpe.net.cable.rogers.com ([24.112.38.222]:45576
	"EHLO cpe00606767ed59.cpe.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S319564AbSIHDpq>; Sat, 7 Sep 2002 23:45:46 -0400
Date: Sat, 7 Sep 2002 23:51:47 -0400 (EDT)
From: "D. Hugh Redelmeier" <hugh@mimosa.com>
Reply-To: "D. Hugh Redelmeier" <hugh@mimosa.com>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Tommi Kyntola <kynde@ts.ray.fi>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
In-Reply-To: <20020820172215.GE19225@waste.org>
Message-ID: <Pine.LNX.4.44.0209072344550.21724-100000@redshift.mimosa.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| From: Oliver Xymoron <oxymoron@waste.org>
| Date: Tue, 20 Aug 2002 12:22:16 -0500

| On Tue, Aug 20, 2002 at 07:19:26PM +0300, Tommi Kyntola wrote:

| >  Does strict gamma assumption 
| > really lead to so strict figures as you showed in your patch :
| > static int benford[16]={0,0,0,1,2,3,4,5,5,6,7,7,8,9,9,10};
| > 
| > Numbers below 0..7, don't have a single bit of entropy?
| 
| They have fractional bits of entropy.

If entropy is added in such small amounts, should the entropy counter
be denominated in, say, 1/4 bits?  Would this allow the entropy
estimate to safely grow significantly faster?  Are the estimates
accurate enough to justify such precision?

Hugh Redelmeier
hugh@mimosa.com  voice: +1 416 482-8253

