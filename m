Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWBQBrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWBQBrM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 20:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWBQBrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 20:47:12 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:6757 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750740AbWBQBrL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 20:47:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SNryTRodXwsojpmiIlL1hOYF7Yx2O2i0DD8f7b6FcU9kJY+KROr7cY8K9P71RAUbgnBoAzWT8+cDEx1TB2MSAyQZEANsBjVuN/MwkMReM0Ejtn8rGNibY35DQbROMnrsck4MFsmMnpQJJjQSarKtLgt2GzV0Q3CyanJ+5QGdgWI=
Message-ID: <d120d5000602161747g360b4a69w81d9780b6fa7d0b9@mail.gmail.com>
Date: Thu, 16 Feb 2006 20:47:10 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] make INPUT a bool
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
In-Reply-To: <20060216232205.GC4422@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060214152218.GI10701@stusta.de>
	 <200602150120.58844.dtor_core@ameritech.net>
	 <20060216232205.GC4422@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/06, Adrian Bunk <bunk@stusta.de> wrote:
> On Wed, Feb 15, 2006 at 01:20:58AM -0500, Dmitry Torokhov wrote:
> > On Tuesday 14 February 2006 10:22, Adrian Bunk wrote:
> > > Make INPUT a bool.
> > >
> > > INPUT!=y is only possible if EMBEDDED=y, and in such cases it doesn't
> > > make that much sense to make it modular.
> > >
> >
> > Adrian,
> >
> > We also need to get rid of input_register_device pinning input module
> > and input_dev release function decrementing module's refcount.
>
> Is the patch below OK?
>

Looks great! Thank you, Adrian.

--
Dmitry
