Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVB1QpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVB1QpA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 11:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVB1Qo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 11:44:59 -0500
Received: from sd291.sivit.org ([194.146.225.122]:30339 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261678AbVB1Qo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 11:44:58 -0500
Date: Mon, 28 Feb 2005 17:44:56 +0100
From: Stelian Pop <stelian@popies.net>
To: colbuse@ensisun.imag.fr
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 3/2] drivers/char/vt.c: remove unnecessary code
Message-ID: <20050228164456.GB17559@sd291.sivit.org>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	colbuse@ensisun.imag.fr, linux-kernel@vger.kernel.org,
	arjan@infradead.org
References: <1109603174.42233366e4fed@webmail.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109603174.42233366e4fed@webmail.imag.fr>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 04:06:14PM +0100, colbuse@ensisun.imag.fr wrote:

> +               /* Setting par[]'s elems at 0.  */
> +               memset(par, 0, NPAR*sizeof(unsigned int));

No need for the comment here, everybody understands C.

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
