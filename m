Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVEQDXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVEQDXF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 23:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVEQDXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 23:23:04 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:9890 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S261212AbVEQDXB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 23:23:01 -0400
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Matt Mackall <mpm@selenic.com>
Subject: Re: serial console
Date: Mon, 16 May 2005 22:19:18 -0400
User-Agent: KMail/1.6.2
Cc: YhLu <YhLu@tyan.com>, linux-tiny@selenic.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <3174569B9743D511922F00A0C943142309F80D9F@TYANWEB> <20050516205731.GA5914@waste.org> <20050516231508.GD5914@waste.org>
In-Reply-To: <20050516231508.GD5914@waste.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200505162219.18345.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 May 2005 07:15 pm, Matt Mackall wrote:

> +int __init add_preferred_console(char *name, int idx, char *options)
> +{
> +	return 0;
> +}
> +

Inline that puppy please.  I can be optimized away.  Having it be __init makes 
no sense...

Rob
