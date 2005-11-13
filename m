Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVKMSY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVKMSY3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 13:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbVKMSY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 13:24:29 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:49777 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750715AbVKMSY2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 13:24:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F0CDDPZ05MixMFyWmv/GWxsIYiS5qm4q+HzZWynT7jPDA6TTJiG/UZOTdSpATVf6jiN4/1CzSyqFvLsTVQNW9Khg2Mk2nMAJrXqT6ivLZcH2uD24/Odglm14S2MwpAmnd4thsnQc1BiAy2ObO7YlpKP1Vy/wtvlwWPFEn9FYn0A=
Message-ID: <625fc13d0511131024j7a7af5a4xc00f4433d1e7e8af@mail.gmail.com>
Date: Sun, 13 Nov 2005 12:24:28 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] Remove include/linux/mtd/compatmac.h
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
In-Reply-To: <20051112205610.GA20860@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051112205610.GA20860@mipter.zuzino.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/05, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> From: Alexey Dobriyan <adobriyan@gmail.com>
>
> File is effectively empty.

I would prefer not to do this.  The file is effectively empty in
Linus' tree, but it's quite full of stuff in MTD CVS.  It's not really
hurting anything being there and makes the merge from MTD CVS easier.

josh
