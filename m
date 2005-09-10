Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbVIJX1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVIJX1a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 19:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbVIJX13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 19:27:29 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:5048 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932376AbVIJX13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 19:27:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=W54hVgpUBb481nLMNllylep1xmHWD/b9ljsf629SeIFEpStPfZsHH4C+HSHt1tz5YzseF88t/WZ8mUA1kDzYcphV/rWDJarbYOsDAOHdn7rRcBcuRrQd+339rlgGVCYa9jVbXaFCp7kguFCRQdcA+CtQxiBbbHMwNGsSi0AAF7o=
Message-ID: <43236BA1.30005@gmail.com>
Date: Sun, 11 Sep 2005 07:26:25 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: Antonino Daplas <adaplas@pol.net>, Al Viro <viro@zeniv.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix breakage on ppc{,64} by "nvidiafb: Fallback to firmware
 EDID"
References: <20050910225307.GA7654@mipter.zuzino.mipt.ru>
In-Reply-To: <20050910225307.GA7654@mipter.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> Fix
> 
> drivers/video/nvidia/nv_of.c:34: error: conflicting types for 'nvidia_probe_i2c_connector'
> drivers/video/nvidia/nv_proto.h:38: error: previous declaration of 'nvidia_probe_i2c_connector' was here
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Thanks.

Acked-by: Antonino Daplas <adaplas@pol.net>
