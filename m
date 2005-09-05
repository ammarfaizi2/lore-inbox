Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbVIEM46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbVIEM46 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 08:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbVIEM46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 08:56:58 -0400
Received: from nproxy.gmail.com ([64.233.182.204]:39468 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751231AbVIEM45 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 08:56:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nwtxlpMA0ulUkBNYt5EZuj/1wXf8af/8a9iY+ji5Blgy2idGlUBjy2ucD2/k++mWBw0AqiTQ3hObGJ6xVWUU9dQDIfnYORyEDaHEW2EEXAZFkBrGqH7JigMMC58oAT7i/wuNAnSn2PSGh1w0TBQ9jQqvX7oNsS881QgoaXA2NKg=
Message-ID: <84144f02050905055633713bd3@mail.gmail.com>
Date: Mon, 5 Sep 2005 15:56:48 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Howard Chu <hyc@symas.com>
Subject: Re: 2.6, devfs, SMP, SATA
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <431B7BE2.9070806@symas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d2a0e906050903212678ad88a1@mail.gmail.com>
	 <81b0412b0509041529524bca1f@mail.gmail.com>
	 <431B7BE2.9070806@symas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/05, Howard Chu <hyc@symas.com> wrote:
> So, any guesses why with otherwise identical config options, a kernel
> with SMP enabled doesn't boot up with all of the device nodes that it
> should? (Both drives are on the same controller. I haven't checked to
> see if any other device files are missing.)

Devfs is disabled in 2.6.13 as it most likely will be going away soon.
See http://marc.theaimsgroup.com/?l=linux-kernel&m=111939455921877&w=2.

                            Pekka
