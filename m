Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbVKLWNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbVKLWNj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 17:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbVKLWNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 17:13:39 -0500
Received: from mail.isurf.ca ([66.154.97.68]:14812 "EHLO columbo.isurf.ca")
	by vger.kernel.org with ESMTP id S964845AbVKLWNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 17:13:39 -0500
From: "Gabriel A. Devenyi" <ace@staticwave.ca>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] drivers/message/i2o/i2o_block.c unsigned comparison
Date: Sat, 12 Nov 2005 17:13:26 -0500
User-Agent: KMail/1.8.3
Cc: markus.lidel@shadowconnect.com, linux-kernel@vger.kernel.org
References: <200511121629.54699.ace@staticwave.ca> <20051112221955.GF20860@mipter.zuzino.mipt.ru>
In-Reply-To: <20051112221955.GF20860@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511121713.26671.ace@staticwave.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 12, 2005 17:19, Alexey Dobriyan wrote:
> Don't you see this?

*turns red* I just checked for a compile error, sorry.

>   CC      drivers/message/i2o/i2o_block.o
> drivers/message/i2o/i2o_block.c:961: warning: initialization from incompatible pointer type
> 
> ->ioctl method takes "unsigned long arg".

So should this comparasion arg < 0 simply be removed? Its meaningless if arg is unsigned.

-- 
Gabriel A. Devenyi
ace@staticwave.ca
