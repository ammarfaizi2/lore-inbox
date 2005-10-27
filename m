Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbVJ0PWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbVJ0PWs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 11:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbVJ0PWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 11:22:48 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:41123 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751064AbVJ0PWr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 11:22:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SlH69B+LWIgtScv2g7OVAprP19WtK3rHjPoPWS8HxVoXN32nYaKaS4m1ZAJ4JuAsCB3HLHX3w2qkNf02fH5B7xsgBgckzWsrobqPlmIXKwlnP/KbO+LiWzrpUsqRdQr198ALFa+S8odUV91vOzdigd46JG8tXcgHtVQBYcDnBEI=
Message-ID: <35fb2e590510270822q39db180fh530ce80bb9ec57ba@mail.gmail.com>
Date: Thu, 27 Oct 2005 16:22:45 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Paul Albrecht <palbrecht@qwest.net>
Subject: Re: yet another c language cross-reference for linux
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000501c5daf1$bbd37c60$e8c90443@oemcomputer>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <000501c5daf1$bbd37c60$e8c90443@oemcomputer>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/05, Paul Albrecht <palbrecht@qwest.net> wrote:

> I have written another cross-referencing tool for the c language because I
> have been dissatisfied with existing tools such as ctags and lxr.

Ok.

> I'd like to get some feedback to determine whether other programmers
> find the program useful

It seems to be in its very early stages now. I can barely navigate the
2.4.31 source and it doesn't offer anything like the functionality of
lxr. But if you want to, perhaps it's worthwhile developing it further
and releasing it.

Your README file suggests that LXR fails because it requires a
webserver. Personally, I've never seen that to be an issue and find it
very very useful indeed (although it has limitations and doesn't
always index every symbol I would want to lookup), especially with
coywolf keeping an up-to-date lxr for 2.6. Mel Gorman used it for his
ULVMM book and I'm sure others are using LXR extensively - so it might
be worth extending that.

I'd love it if vendors would actually index their kernels with LXR.

Jon.
