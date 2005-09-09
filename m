Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030435AbVIIUIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030435AbVIIUIr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 16:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbVIIUIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 16:08:47 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:7141 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030435AbVIIUIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 16:08:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=l6NszMHOLk+zJzdXmHgUBdlEp1z/dqoV77U3ajf9G6CoGpPU8TyXfpxrGbbonHxZjvmNEB9D1/rFYKnwwYv6qolD/+lKj+SHNOdS8DJC0iCYd20OZR6oIhE96a82DyJHScT8iNna2RYA3oO3a3CA7MPnjrEXmuLYgoqvRUk4ouE=
Date: Sat, 10 Sep 2005 00:18:34 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2.6.13 1/20] aic94xx: Makefile
Message-ID: <20050909201834.GA24521@mipter.zuzino.mipt.ru>
References: <4321E335.5010805@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4321E335.5010805@adaptec.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 03:32:05PM -0400, Luben Tuikov wrote:
> --- linux-2.6.13-orig/drivers/scsi/aic94xx/Makefile
> +++ linux-2.6.13/drivers/scsi/aic94xx/Makefile

> +CHECK = sparse -Wbitwise

	make C=1 CHECK="sparse -Wbitwise"
or
	make C=1

> +clean-files += *~

Don't override what other people want.

