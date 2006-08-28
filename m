Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWH1Ewt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWH1Ewt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 00:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWH1Ewt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 00:52:49 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:37415 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932311AbWH1Ews (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 00:52:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gbv5qdIhU4XlUrX5r3sQqTM67v30vCqEg2tTFC/2LO7Fj+VU0sewqhl0VUbGhVinWKSSTqinz4MXxPaeA00H3VeDxyVEeq5VH/tDHsAkZ1h9c1Wl+fjCSPgxFK+6UkCPGzWNjIJn+8i60Oux2xtbxmipYPm0gaHdxA8ZZqALfY0=
Message-ID: <18d709710608272152g4995e492k7e832178ac30bfa0@mail.gmail.com>
Date: Mon, 28 Aug 2006 01:52:47 -0300
From: "Julio Auto" <mindvortex@gmail.com>
To: "Solar Designer" <solar@openwall.com>
Subject: Re: [PATCH] loop.c: kernel_thread() retval check - 2.6.17.9
Cc: "Willy Tarreau" <w@1wt.eu>, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20060828035556.GA27902@openwall.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <18d709710608232341x491b4bf6g87f74ef830a203@mail.gmail.com>
	 <20060828035556.GA27902@openwall.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/06, Solar Designer <solar@openwall.com> wrote:
> I think that testing this on a single machine is fine, but it is
> preferable that you also check for any resource leaks.  That is, replace
> the kernel_thread() call with -EAGAIN, then run losetup in a loop and
> see whether the system possibly leaks a resource.  I did apply this sort
> of testing to my original 2.4 patch.
>

That was exactly the approach I took. :)


    Julio Auto
