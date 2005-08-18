Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbVHRX3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbVHRX3k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 19:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVHRX3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 19:29:40 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:51171 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932410AbVHRX3j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 19:29:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d/K/nyGe9sf0pPfxuDxKSXcuiNufgRQ12ZoMCv2SFodbIyNbvkOzU/baFYejhE8VyN9F1yI8lAHxPuet+/CdJr67c3GdAG8ysIM96y09w2b1ed2er+NSdZHl7winZo+h4aUH0jsDqJPha0Ysgq/OrKJNhaIFRT5esY1f2uQgGpo=
Message-ID: <98df96d30508181629d85edb5@mail.gmail.com>
Date: Fri, 19 Aug 2005 08:29:38 +0900
From: Hiro Yoshioka <lkml.hyoshiok@gmail.com>
Reply-To: hyoshiok@miraclelinux.com
To: Hiro Yoshioka <hyoshiok@miraclelinux.com>
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
Cc: ak@suse.de, arjan@infradead.org, taka@valinux.co.jp,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050818.201138.607962419.hyoshiok@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1124187950.3215.31.camel@laptopd505.fenrus.org.suse.lists.linux.kernel>
	 <p73oe7y10qw.fsf@verdi.suse.de>
	 <98df96d305081804061ea70686@mail.gmail.com>
	 <20050818.201138.607962419.hyoshiok@miraclelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/18/05, Hiro Yoshioka <hyoshiok@miraclelinux.com> wrote:
> 1) using stack to save/restore MMX registers

It seems to me that it has some regression.
I'd like to rollback it and use kernel_fpu_begin() and kernel_fpu_end().

Regards,
  Hiro
-- 
Hiro Yoshioka
mailto:hyoshiok at miraclelinux.com
