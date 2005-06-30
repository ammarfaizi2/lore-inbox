Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262975AbVF3ORT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262975AbVF3ORT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 10:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262981AbVF3ORS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 10:17:18 -0400
Received: from smtp1.brturbo.com.br ([200.199.201.163]:44492 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S262975AbVF3OQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 10:16:43 -0400
Message-ID: <42C3F871.7060008@brturbo.com.br>
Date: Thu, 30 Jun 2005 10:49:37 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: mkrufky@m1k.net, Linux and Kernel Video <video4linux-list@redhat.com>,
       trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL PATCH] v4l cx88 hue offset fix
References: <42C35C65.8030900@m1k.net>
In-Reply-To: <42C35C65.8030900@m1k.net>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky wrote:
> 
> 
> ------------------------------------------------------------------------
> 
>   Changed hue offset to 128 to correct behavior in cx88 cards.
>   Previously, setting 0% or 100% hue was required to avoid blue/green
>   people on screen.  Now, 50% Hue means no offset, just like bt878 stuff.
> 
> Signed-off-by: Michael Krufky <mkrufky@m1k.net>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
> 
Acked-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

	This small patch fixes top complain about CX88 cards, which had a
different behavior than other V4L cards for hue setting.

	It can also be applied also at 2.6.13 mainstream.
