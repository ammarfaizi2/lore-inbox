Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbVHHRfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVHHRfk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbVHHRfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:35:40 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:26260 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932138AbVHHRfk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:35:40 -0400
Subject: Re: [PATCH] spi
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <greg@kroah.com>
Cc: dmitry pervushin <dpervushin@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050808145544.GB6478@kroah.com>
References: <1121025679.3008.10.camel@spirit>
	 <1123492338.4762.96.camel@diimka.dev.rtsoft.ru>
	 <20050808145544.GB6478@kroah.com>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 19:35:36 +0200
Message-Id: <1123522536.7751.51.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> No spaces after ( or before ) please.  You do this all over the place in
> the code, please fix it up.
> 
> > +	if (NULL == dev || NULL == driver) {
> 
> Put the variable on the left side, gcc will complain if you incorrectly
> put a "=" instead of a "==" here, which is all that you are defending
> against with this style.

I think in this case the preferred way is

	if (!dev || !driver) {

Regards

Marcel


