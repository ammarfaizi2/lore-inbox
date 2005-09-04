Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbVIDRMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVIDRMl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 13:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbVIDRMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 13:12:41 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:20785 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932073AbVIDRMk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 13:12:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CC7TofH3nF3db3+IXzYX4vbDw2uXDF1Rx7JVTNpTAeKjb5e4kRGTZ/a/sa7UoCnzg/sBfvrIFLhfrZmcOzBi6vJJFn2iE3jwHErnN/R7bQR2+KoB0DeO2AY6581+6iezGMhTl9Jdl8Ibd5U8WA6YNwNGx1b9cG8EWv17KcR3k0E=
Message-ID: <6880bed305090410127f82a59f@mail.gmail.com>
Date: Sun, 4 Sep 2005 19:12:33 +0200
From: Bas Westerbaan <bas.westerbaan@gmail.com>
Reply-To: bas.westerbaan@gmail.com
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: RFC: i386: kill !4KSTACKS
Cc: Paul Misner <paul@misner.org>, linux-kernel@vger.kernel.org
In-Reply-To: <84144f02050904100721d3844d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050902060830.84977.qmail@web50208.mail.yahoo.com>
	 <200509041549.17512.vda@ilport.com.ua>
	 <200509041144.13145.paul@misner.org>
	 <84144f02050904100721d3844d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes you are. You're asking for 4KSTACKS config option to maintained
> and it is not something you get for free. Besides, if it is indeed
> ripped out of mainline kernel, you can always keep it a separate patch
> for ndiswrapper.

Though 4K stacks are used a lot, they probably aren't used on all
configurations yet. Other situations may arise where 8K stacks may be
preferred. It is too early to kill 8K stacks imho.
-- 
Bas Westerbaan
http://blog.w-nz.com/
GPG Public Keys: http://w-nz.com/keys/bas.westerbaan.asc
