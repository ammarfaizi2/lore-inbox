Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVL3DRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVL3DRu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 22:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVL3DRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 22:17:50 -0500
Received: from mx.pathscale.com ([64.160.42.68]:1686 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750806AbVL3DRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 22:17:50 -0500
Subject: Re: [PATCH 0 of 20] [RFC] ipath - PathScale InfiniPath driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <200512291901.jBTJ1rOm017519@laptop11.inf.utfsm.cl>
References: <200512291901.jBTJ1rOm017519@laptop11.inf.utfsm.cl>
Content-Type: text/plain
Date: Thu, 29 Dec 2005 19:17:29 -0800
Message-Id: <1135912649.7790.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-29 at 16:01 -0300, Horst von Brand wrote:

> >   - Renamed _BITS_PER_BYTE to BITS_PER_BYTE, and moved it into
> >     linux/types.h

> Haven't come across anything with this not 8 for a /long/ time now, and no
> Linux on that in sight.

The point isn't that it might change, but that it makes code clearer to
use BITS_PER_BYTE in arithmetic than to have the magic number 8
sprinkled around mysteriously.

	<b

