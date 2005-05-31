Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVEaUkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVEaUkR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 16:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVEaUkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 16:40:17 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:28485 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261442AbVEaUkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 16:40:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Q3rXOtTLXO3QahQwyYL4b4zli1OX1vUZoEuyej4Shax8f+4NL5tHXjfXtIO20dqnynu22y8zRP+9zG9aUBEldFm2cxzJPrnJ29SuhkBzWBvASpKT7ns1ZogEaogVTRILxWA6m3oi8pdbdEOB7w+bw2dxSEsaD6kkDfrQUdX4BVA=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: dpervushin@ru.mvista.com
Subject: Re: [RFC] SPI core
Date: Wed, 1 Jun 2005 00:44:34 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <1117555756.4715.17.camel@diimka.dev.rtsoft.ru>
In-Reply-To: <1117555756.4715.17.camel@diimka.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506010044.34559.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 May 2005 20:09, dmitry pervushin wrote:
> In order to support the specific board, we have ported the generic SPI core
> to the 2.6 kernel. This core provides basic API to create/manage SPI devices
> like the I2C core does. We need to continue providing support of SPI devices
> and would like to maintain the SPI subtree.

> +#ifdef CONFIG_DEVFS_FS
> +#include <linux/devfs_fs_kernel.h>
> +#endif

devfs will be removed from mainline in a month.
