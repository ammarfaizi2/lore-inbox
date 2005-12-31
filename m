Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbVLaJzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbVLaJzK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 04:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVLaJzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 04:55:10 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:19400 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932121AbVLaJzI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 04:55:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HQ51yI+1K0li97c3qlLerUduUMoyAqtsz2jsM4K5lZStQwqL2tygEz341jwEPXyaC3bW27H3iKFsM8zFOw+LUQ7J9b9yHWR7wStlliqcGlkQtuvweho7FDAyKErKH89v9PtSZJ2eI/iS/CrUY9CPsWD+QoRRHnivLxcp7QvKIlg=
Message-ID: <84144f020512310155r4e99006cn21c5d622b544baa1@mail.gmail.com>
Date: Sat, 31 Dec 2005 11:55:06 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: Integer types
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051231084719.GA6702@optonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051231084719.GA6702@optonline.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/31/05, Jeff Sipek <jeffpc@optonline.net> wrote:
> What's the prefered integer type for kernel code?
>
> * u8, u16, ...
> * uint8_t, uint16_t, ...
> * u_int8_t, t_int16_t, ...

>From the above list, the first ones. See
http://article.gmane.org/gmane.linux.kernel/259313. Please note that
there's also __le32 and __be32 for variables that have fixed byte
ordering.

                            Pekka
