Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262911AbTDII1i (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 04:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbTDII1i (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 04:27:38 -0400
Received: from 237.oncolt.com ([213.86.99.237]:63705 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S262911AbTDII1h (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 04:27:37 -0400
Subject: Re: [PATCH] compatmac is not needed
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: alan@lxorguk.ukuu.org.uk
In-Reply-To: <200304081725.h38HPeSV012611@hera.kernel.org>
References: <200304081725.h38HPeSV012611@hera.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1049877554.31462.24.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Wed, 09 Apr 2003 09:39:15 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-08 at 17:42, Linux Kernel Mailing List wrote:
> ChangeSet 1.1089, 2003/04/08 09:42:06-07:00, alan@lxorguk.ukuu.org.uk
> 
> 	[PATCH] compatmac is not needed

Er, compatmac is there to make new code work in older kernels. The only
concession we have to make for compatibility in the actual code is that
#include, and we put all the ugliness into compatmac.h which makes it
work in older kernels. 

So compatmac.h ends up _empty_ in the latest kernel, but that doesn't
mean it's not needed.

Please don't break stuff just for the sake of it.

-- 
dwmw2

