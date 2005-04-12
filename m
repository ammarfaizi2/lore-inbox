Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262411AbVDLRM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbVDLRM1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 13:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVDLRKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 13:10:11 -0400
Received: from mx3.mail.ru ([194.67.23.149]:45405 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S262411AbVDLRIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 13:08:45 -0400
From: Alexey Dobriyan <adobriyan@mail.ru>
To: roland@topspin.com
Subject: Re: [patch 164/198] IB/mthca: fill in more device query fields
Date: Tue, 12 Apr 2005 21:11:34 +0000
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <200504121033.j3CAXDWW005823@shell0.pdx.osdl.net>
In-Reply-To: <200504121033.j3CAXDWW005823@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504122111.34696.adobriyan@mail.ru>
X-Spam: Probable Spam
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 April 2005 10:33, akpm@osdl.org wrote:

> Implement more of the device_query method in mthca.

> --- 25/drivers/infiniband/hw/mthca/mthca_provider.c~ib-mthca-fill-in-more-device-query-fields
> +++ 25-akpm/drivers/infiniband/hw/mthca/mthca_provider.c
> @@ -52,6 +52,8 @@ static int mthca_query_device(struct ib_

> +	memset(props, 0, sizeof props);

sizeof *props ?
