Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWDLGmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWDLGmE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 02:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWDLGmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 02:42:04 -0400
Received: from wproxy.gmail.com ([64.233.184.237]:18826 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932072AbWDLGmD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 02:42:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HGxCgCimj1xABplPvwL9hwtje7pgx3Wb6mNI9Ea0Zr/rHy5STN2WT76O6BHNJ10BgQdMmO9a5UXW73l9iPtFmmFn1DEKhxujwrOTMjwHeZu3Y92Zy2uZRrU+IQV9mVIll3yC0XJ1Z2W7vNIPL6WYdugAsfEOUsOxnDO1lZFFH7o=
Message-ID: <84144f020604112342v47a734a1t26f49e44c0d6b870@mail.gmail.com>
Date: Wed, 12 Apr 2006 09:42:02 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: hzy@cs.otago.ac.nz
Subject: Re: Re: Slab corruption after unloading a module
Cc: "Hareesh Nagarajan" <hnagar2@gmail.com>, linux-kernel@vger.kernel.org,
       zhiyi6@xtra.co.nz
In-Reply-To: <20060412040756.YSVZ11236.web3-rme.xtra.co.nz@202.27.184.228>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060412040756.YSVZ11236.web3-rme.xtra.co.nz@202.27.184.228>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/06, Zhiyi Huang <zhiyi6@xtra.co.nz> wrote:
> Thanks for help. I already configured the kernel with CONFIG_DEBUG_SLAB=y,
> but I changed the current log level from 7 to 8. I got similar messages below.
> I still have no clue. The messages show nothing about my module. Any more
> suggestions?

2.6.8 is an old kernel, you could very well be hitting a kernel bug
that has been fixed already. Can you reproduce this with 2.6.16? Also,
you're not including sources to your module so it's impossible to tell
whether you're doing something wrong.

                                                         Pekka
