Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161114AbWAHAyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161114AbWAHAyz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 19:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161115AbWAHAyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 19:54:54 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:33001 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161114AbWAHAyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 19:54:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=m9Cs7GSlcMvyxVH8sQX6VWp8Q6VMwqyAESllGJf3sFPk9lYt1Zhhzix3lSVLO7yP4TZ9EjMs3e/jvkdKDzFlfxrzDYxkeCnHuBr2aMb0w+/6yCEnf5puQKjRd70eRIIVEa4TgEKM/3MmJTB+hmzKKGN05gtH//BDIPYAsvCPYrM=
Message-ID: <43BEE057.6000603@gmail.com>
Date: Sat, 07 Jan 2006 05:25:43 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Thomas Koeller <thomas@koeller.dyndns.org>
CC: adaplas@pol.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] non-linear frame buffer read/write access
References: <200601032339.24927.thomas@koeller.dyndns.org>
In-Reply-To: <200601032339.24927.thomas@koeller.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Koeller wrote:
> While the code in fbmem.c allows for hooking read/write access
> to non-linear frame buffers by means of fb_read and fb_write
> in struct fb_ops, I could not find a way tho access the actual
> frame buffer memory from within these routines. I therefore
> had to patch fbmem.c, to be able to retrieve a pointer to
> struct fb_info from the 'file' argument to these functions.
> 
> The second hunk of the patch is not strictly required, I only
> did that for symmetry reasons (and the code is somewhat
> shorter).
> 
> Patch is against 2.6.14
> 
> Signed-off-by: Thomas Koeller <thomas@koeller.dyndns.org>

Okay.

Tony

