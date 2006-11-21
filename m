Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030804AbWKUKFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030804AbWKUKFn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 05:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030811AbWKUKFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 05:05:43 -0500
Received: from nz-out-0102.google.com ([64.233.162.196]:39487 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030804AbWKUKFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 05:05:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Uf28XoWEDiuBh88UFDjT0oIxiiSswWj5rE49ePdwVX0wNZiN+IfT+Y3FVn+kFlAOdAvPRgK5E2rQoWYeq+iuqEIyTihowOIsi6HKXyqParnsz7jy8pBSxWYacGWm6yfm5t8GDMX6auZ3wLBmiUoBkfGOqfcgRPgTgNQqFa7vBQI=
Message-ID: <9a8748490611210205v7beea9aer7c511f2dd4dbf95a@mail.gmail.com>
Date: Tue, 21 Nov 2006 11:05:40 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Dipti Ranjan Tarai" <dipti@innomedia.soft.net>
Subject: Re: How to read/write from/to the HD with out kernel cashing
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4562CCB2.1030400@innomedia.soft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4562CCB2.1030400@innomedia.soft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/06, Dipti Ranjan Tarai <dipti@innomedia.soft.net> wrote:
> Hi all,
>        I am using fedora core -3 with kernel 2.6.10. I want to
> read/write a sector from/to the HD with out kernel caching. Basically my
> aim is to communicate directly with the ide drivers so that I can bypass
> the kernel cache. Please give some idea regarding this.
>
Why wouldn't the (obsolete) RAW driver (CONFIG_RAW_DRIVER) or (better)
O_DIRECT work for you??

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
