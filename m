Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWEOKPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWEOKPo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 06:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWEOKPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 06:15:43 -0400
Received: from wx-out-0102.google.com ([66.249.82.202]:10725 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932348AbWEOKPn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 06:15:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FkB4gbvMvGsfJwkCQiH34YZkljglvBWXhFaKRZ66a4+Bngxo37ceSuoc1Z0+GNusGFkSwNUEFPS9idlXkEiCeFZUmvVA7mOxdXxajjBm4K+WtELQZKPMCXYTp1gnMF+JK4T1MZ7h5gwMht7Yues7s8GCzLq56m9m4dNzfbwbTbU=
Message-ID: <b0943d9e0605150315l7da57816yfa10ffae2b04fe79@mail.gmail.com>
Date: Mon, 15 May 2006 11:15:42 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Ingo Oeser" <ioe-lkml@rameria.de>
Subject: Re: [PATCH 2.6.17-rc4 1/6] Base support for kmemleak
Cc: "Jesper Juhl" <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200605141932.10799.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060513155757.8848.11980.stgit@localhost.localdomain>
	 <9a8748490605131042w3214a7b8lb9a862798e3131d4@mail.gmail.com>
	 <4466DB13.5090104@gmail.com> <200605141932.10799.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/06, Ingo Oeser <ioe-lkml@rameria.de> wrote:
> On Sunday, 14. May 2006 09:24, Catalin Marinas wrote:
> > The best would be to test it using a loadable module but I did most of
> > the work on an embedded ARM platform where it was much easier to add
> > some code directly. The code will be cleaned up in subsequent versions.
>
> Fair enough. Just put it in a seperate file,
> add a Kconfig "TEST_MEMLEAK_DETECTOR" tristate option,
> depending on "DEBUG_MEMLEAK" and adjust the Makefile accordingly.

I'll do this since the patch needs a lot more testing to show that it
can actually find real bugs and also determine its limitations. I
posted this first version to see what people think about it but it is
far from the final version.

-- 
Catalin
