Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbVIJWv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbVIJWv7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbVIJWv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:51:59 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:63707 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932314AbVIJWv6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:51:58 -0400
Date: Sat, 10 Sep 2005 23:51:53 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix breakage on ppc{,64} by "nvidiafb: Fallback to firmware EDID"
Message-ID: <20050910225153.GF25261@ZenIV.linux.org.uk>
References: <20050910225307.GA7654@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050910225307.GA7654@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2005 at 02:53:07AM +0400, Alexey Dobriyan wrote:
> Fix
> 
> drivers/video/nvidia/nv_of.c:34: error: conflicting types for 'nvidia_probe_i2c_connector'
> drivers/video/nvidia/nv_proto.h:38: error: previous declaration of 'nvidia_probe_i2c_connector' was here
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

ACK (and merged in -bird, but I hope it gets into Linus' tree before the
final rediff for today ;-)
