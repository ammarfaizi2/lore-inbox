Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWIOXEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWIOXEi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 19:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWIOXEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 19:04:38 -0400
Received: from smtp-out.google.com ([216.239.45.12]:42224 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932352AbWIOXEi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 19:04:38 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=K6byZUg0DyGeI7Np9GOBI5mSa84nSCB29N6DL8x4ihLu7dYyooTVP1p/9vA4YTX3N
	ATzmsUqVj/N4EfUAJSuTQ==
Message-ID: <d43160c70609151604pfe83b3nc130f2abc250baa6@mail.google.com>
Date: Fri, 15 Sep 2006 19:04:30 -0400
From: rossb <rossb@google.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: + allow-proc-configgz-to-be-built-as-a-module.patch added to -mm tree
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mm-commits@vger.kernel.org,
       akpm@google.com, sam@ravnborg.org
In-Reply-To: <20060915154752.d7bdb8a0.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200609152158.k8FLw7ud018089@shell0.pdx.osdl.net>
	 <20060915154752.d7bdb8a0.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > In some ways this is a bit risky, because the .config which is used for
> > compiling kernel/configs.c isn't necessarily the same as the .config which was
> > used to build vmlinux.
>
> and that's why a module wasn't allowed.
> It's not worth the risk IMO.

It's not worth the risk for distributions or if you are tyring to
support people building their own kernels.  But if you are in an
environment where you have enough control that you are not worried the
kernel and the module being built at separate times or with different
configs, then it's a nice compromise between convenience and memory
use.

    Ross
