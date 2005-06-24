Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263315AbVFXV3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbVFXV3l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 17:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbVFXVXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 17:23:22 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:51270 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263303AbVFXVVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 17:21:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MvxuOxjgRYVJlOyfx7K6WXcg0XVzI5LZQJjZMsCdJknyEWTc79MQ0DM2KpIjkZ6Otg589rWf3a/eD5istoBCl9RyJuORonicEScq32EWFCxoJy+fvEwvDWIFmjdfSxjePOCr1aUDhmNMf/ipi/hlcQUsDR1xtJgH0nLd7mHqXj8=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Dominik Karall <dominik.karall@gmx.net>
Subject: Re: 2.6.12-rc6-mm1
Date: Sat, 25 Jun 2005 01:27:25 +0400
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050607042931.23f8f8e0.akpm@osdl.org> <200506211520.44645.dominik.karall@gmx.net>
In-Reply-To: <200506211520.44645.dominik.karall@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506250127.26589.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 June 2005 17:20, Dominik Karall wrote:
> After looking in my dmesg output today, I saw following error with 
> 2.6.12-rc6-mm1, maybe it's usefull to you. I don't know when it exactly 
> happens, cause I never used mono last time, I just did an emerge mono on my 
> gentoo system, maybe this forced the failure.
> 
> note: mono[26736] exited with preempt_count 1
> scheduling while atomic: mono/0x10000001/26736

I've filed a bug at kernel bugzilla, so your report won't be lost.
See http://bugme.osdl.org/show_bug.cgi?id=4794

You can register at http://bugme.osdl.org/createaccount.cgi and add yourself
to CC list.
