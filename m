Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWCSSFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWCSSFy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 13:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWCSSFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 13:05:54 -0500
Received: from 62-177-247-250.dyn.bbeyond.nl ([62.177.247.250]:33037 "EHLO
	www.ithos.nl") by vger.kernel.org with ESMTP id S932156AbWCSSFx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 13:05:53 -0500
Date: Sun, 19 Mar 2006 18:52:07 +0100 (CET)
From: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
X-X-Sender: rbultje@www.ithos.nl
To: Martin Samuelsson <sam@home.se>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: saa7111.c patch
In-Reply-To: <20060319114124.11d4fa9d.sam@home.se>
Message-ID: <Pine.LNX.4.56.0603191850450.11360@www.ithos.nl>
References: <20060319114124.11d4fa9d.sam@home.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 19 Mar 2006, Martin Samuelsson wrote:
> When grabbing composite video with Iomega Buz, the stock driver will
> prevent grabbing from the same input twice in a row, forcing the user
> to switch inputs before anything useful can be grabbed again. It is
> caused by some optimization code in the input selection parts, and
> triggered by the saa7111_command() executing cmd 0. The attached patch
> will remedy this by disabling cmd 0 altogether; a fix that has no found
> negative effects on the rest of the code. In fact, saa7110.c does the
> exact same thing.

I second this patch, can you please add it to your tree? Thanks,

Ronald
