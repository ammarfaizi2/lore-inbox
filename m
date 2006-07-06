Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWGFSFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWGFSFP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 14:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWGFSFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 14:05:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:51322 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750820AbWGFSFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 14:05:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Reh9LiDJ4GTT0Zg6F5IGzNnxCc0mUiboF2GKo4VxZUyEJoD8PQ1P75wjuYw2PGafa3x3XMv0K2krZvLrQYf5P7R/zY/yekKsHNwNvvywbmsQ8R0Js1kHa7PYzk/RoZM8z3XAE1aDKdhrCE3dGvAWybhOVBHwaClSUkOJiRdbDlc=
Message-ID: <9a8748490607061105r602afaa0l1132bba04f6ae663@mail.gmail.com>
Date: Thu, 6 Jul 2006 20:05:12 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Cc: kai@germaschewski.name, sam@ravnborg.org, linux-kernel@vger.kernel.org,
       "Dave Jones" <davej@redhat.com>
In-Reply-To: <20060706163728.GN26941@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060706163728.GN26941@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/06, Adrian Bunk <bunk@stusta.de> wrote:
> Currently, using an undeclared function gives a compile warning, but it
> can lead to a nasty to debug runtime stack corruptions if the prototype
> of the function is different from what gcc guessed.
>
> With -Werror-implicit-function-declaration we are getting an immediate
> compile error instead.
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
Makes good sense. It gets my vote.
Thanks Adrian.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
