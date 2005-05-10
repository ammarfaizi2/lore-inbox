Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVEJVUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVEJVUR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 17:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVEJVT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 17:19:26 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:24483 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261798AbVEJVQv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 17:16:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NqngRHiRpUMkjvPFXa5cDu0CE5LzyDQf6PaM6eyPoLFgyPAPdG6w/Rr+BgLWTTQ+vJ2a9BAlneiwZkMjKVZ0cGQrCrChJLnO3NreVrBarDxAhplDiDI0j62p3Y6P+onHVuckSLhLU/de6hmo1AVcTCL57JpLREdnLjQvXFm1WMM=
Message-ID: <7f800d9f050510141626f70ee4@mail.gmail.com>
Date: Tue, 10 May 2005 14:16:51 -0700
From: Andre Eisenbach <int2str@gmail.com>
Reply-To: Andre Eisenbach <int2str@gmail.com>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
Subject: Re: High res timer?
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42811D51.1030106@tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7f800d9f050510132762f0ee7@mail.gmail.com>
	 <42811D51.1030106@tiscali.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/5/10, Matthias-Christian Ott <matthias.christian@tiscali.de>:
>
> What about nanosleep ()?
> 

nanosleep() seems to have some latency very similar to usleep(). Isn't
usleep based on nanosleep()?

Here's what I get if I try to nanosleep for 5 secs (for testing):

-> 5.009952 s

The .009952 part varies, but is very close to that usually.

Thanks,
    Andre
