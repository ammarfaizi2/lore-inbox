Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267727AbUHPPYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267727AbUHPPYg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267842AbUHPPXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:23:43 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:34053 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267734AbUHPPWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:22:07 -0400
Date: Mon, 16 Aug 2004 16:21:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] 2.6.8 synclink_cs.c replace syncppp with genhdlc
Message-ID: <20040816162158.A11863@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paul Fulghum <paulkf@microgate.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <1092669058.2012.11.camel@deimos.microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1092669058.2012.11.camel@deimos.microgate.com>; from paulkf@microgate.com on Mon, Aug 16, 2004 at 10:11:00AM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef CONFIG_HDLC_MODULE
> +#define CONFIG_HDLC 1
>  #endif

shouldn't the drivers depend on hdlc instead?

