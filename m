Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbVHMQfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbVHMQfb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 12:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVHMQfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 12:35:31 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:42435 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932185AbVHMQfa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 12:35:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UBgKjwSoCYxPvtg3csPZikuSpiu7Mgzaza66moHlEu0JhbTfuQIZPvk8w005YuSl0dDNOWsMIMM+/8mJuCDy9RDuUghdpVW4qPwrJQPbDuREybdBMh+7sWtrHCUg0TWqplSgJwDkUiZue1FCRCjT8bHom4p5L+WdoooZCcFaqjU=
Message-ID: <feed8cdd0508130935622387db@mail.gmail.com>
Date: Sat, 13 Aug 2005 09:35:29 -0700
From: Stephen Pollei <stephen.pollei@gmail.com>
To: =?ISO-8859-1?Q?Martin_v=2E_L=F6wis?= <martin@v.loewis.de>
Subject: Re: [Patch] Support UTF-8 scripts
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42FDE286.40707@v.loewis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <42FDE286.40707@v.loewis.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/05, "Martin v. Löwis" <martin@v.loewis.de> wrote:
> This patch adds support for UTF-8 signatures (aka BOM, byte order
> mark) to binfmt_script. 

> With such support, creating scripts that reliably carry non-ASCII
> characters is simplified. 
> the approach would naturally extend to Perl to enhance/replace
> the "use utf8" pragma. 

Thats great for the perl6 people.
http://dev.perl.org/perl6/doc/design/syn/S03.html says they are going
to be using « and » as operators... So I'd imagine that a lot of perl6
scripts would be utf8.

-- 
http://dmoz.org/profiles/pollei.html
http://sourceforge.net/users/stephen_pollei/
http://www.orkut.com/Profile.aspx?uid=2455954990164098214
http://stephen_pollei.home.comcast.net/
