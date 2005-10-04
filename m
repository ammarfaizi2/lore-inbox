Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbVJDDAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbVJDDAn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 23:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVJDDAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 23:00:43 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:2844 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932313AbVJDDAn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 23:00:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o4bLZCqnmOF6cLcHDuZj4WjtFoJDyX82dw8ePDo7qEjknt5uHa1NWAbkbAhmzsXrILpYz/S7zGRZ7LvmOShMvJpkDdHzBySzYqm9REB3ERpNRUZqRddJ2Qi6WMoyBMhVdHXjg135hIFea1Ihw+CauzDZ54s0t9qDsqwywRN19+E=
Message-ID: <5dc44ec70510032000s79e12bc8l2ea4e69af6f32ee7@mail.gmail.com>
Date: Tue, 4 Oct 2005 00:00:41 -0300
From: Diego de Estrada <diego1609@gmail.com>
Reply-To: Diego de Estrada <diego1609@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] release_resource() check for NULL resource
In-Reply-To: <5dc44ec70510031959w1f4adfcbh395535ade34a357d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051002170318.GA22074@home.fluff.org>
	 <20051002103922.34dd287d.rdunlap@xenotime.net>
	 <5dc44ec70510031959w1f4adfcbh395535ade34a357d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/05, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> On Sun, 2 Oct 2005 18:03:18 +0100 Ben Dooks wrote:
>
> > If release_resource() is passed a NULL resource
> > the kernel will OOPS.
>
> does this actually happen?  you are fixing a real oops?
> if so, what driver caused it?

The point is: no driver should make the kernel OOPS. Thanks Ben.
