Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965081AbWEJXbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbWEJXbd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 19:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965082AbWEJXbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 19:31:33 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:62932 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S965081AbWEJXbc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 19:31:32 -0400
Date: Thu, 11 May 2006 01:32:01 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Scott Alfter <salfter@ssai.us>, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Message-ID: <20060510233201.GA6096@linuxtv.org>
References: <44626150.9050804@ssai.us> <20060510223212.GG7237@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060510223212.GG7237@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 84.189.238.57
Subject: Re: [v4l-dvb-maintainer] Re: [PATCH] new driver for TLV320AIC23B
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2006 at 02:32:12AM +0400, Alexey Dobriyan wrote:
> On Wed, May 10, 2006 at 02:55:28PM -0700, Scott Alfter wrote:
> 
> > +	snprintf(client->name, sizeof(client->name) - 1, "tlv320aic23b");
> 
> 	snprintf(buf, sizeof(buf), ...)
> 
> is idiomatic.

better use strlcpy()

Johannes
