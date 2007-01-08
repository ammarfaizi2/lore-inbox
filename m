Return-Path: <linux-kernel-owner+w=401wt.eu-S1422729AbXAHUnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422729AbXAHUnR (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 15:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932662AbXAHUnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 15:43:17 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:50498 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932659AbXAHUnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 15:43:16 -0500
Date: Mon, 8 Jan 2007 21:43:00 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ram <vshrirama@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel compilation - errors
In-Reply-To: <8bf247760701080518s3f58f5aax4250bca4a43e9d59@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0701082142210.23737@yvahk01.tjqt.qr>
References: <8bf247760701080518s3f58f5aax4250bca4a43e9d59@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 8 2007 18:48, Ram wrote:
>
> Actually, the some of the case values are defined as -
>
> case (u32)&CM_ICLKEN_WKUP:
> case (u32)&CM_FCLKEN_WKUP:

This looks like really broken code, if CM_* happen to be constants.


	-`J'
-- 
