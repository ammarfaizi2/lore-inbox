Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750774AbWFEIf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWFEIf3 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWFEIf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:35:28 -0400
Received: from wx-out-0102.google.com ([66.249.82.205]:24884 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750774AbWFEIfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:35:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=StZj6Cdr0cL7RvN3i24bQvBeJ8Y5+wnLZM/Mj62u8dPBM0dycTsMoCmI5u3/9yqfAgBT4/bqmjEOCovXN6S6IXHevbyiQzUnBxIocg0HxJxkGlyHTcjcjEY47QOPd5cdSqGxJ9+MiJ7j/doChAMDA4PBBMZVQFIo8p1YvNvKg8I=
Message-ID: <a44ae5cd0606050135w66c2abeu698394b4268e4790@mail.gmail.com>
Date: Mon, 5 Jun 2006 01:35:18 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Cc: "Jeremy Fitzhardinge" <jeremy@goop.org>, linux-kernel@vger.kernel.org,
        dzickus@redhat.com, ak@suse.de
In-Reply-To: <20060605004823.566b266c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4480C102.3060400@goop.org> <4483DF32.4090608@goop.org>
	 <20060605004823.566b266c.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/06, Andrew Morton <akpm@osdl.org> wrote:

> Do you think the suspend breakage is related to that patch?
>
> Miles also reports that every second suspend fails for him.  Miles, does
> 'nmi_watchdog=0' make it better?

I tried using that as an appended boot option, but it didn't change the
behavior.

    Miles
