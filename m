Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267352AbUI0Un6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267352AbUI0Un6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267345AbUI0Umh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:42:37 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:46217 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S267358AbUI0Uhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:37:33 -0400
Message-ID: <41587A26.6020606@conectiva.com.br>
Date: Mon, 27 Sep 2004 17:37:58 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Organization: Conectiva S.A.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, jgarzik@pobox.com,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: strange network slowness in 2.6 unless pingflooding
References: <20040927090342.GA1794@zip.com.au>
In-Reply-To: <20040927090342.GA1794@zip.com.au>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.005206, version=0.16.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



CaT wrote:
> Hi,
> 
> This is still happening. I ran the same set of tests on a totally
> different network, with my xircom  realport ethernet card (tulip
> driver - 16bit) and from linux to linux and windows to linux. Scrolling
> through a message in mutt eventually slows down and if I lift my finger
> off the enter key whilst it's slow the scrolling keeps going, as if it
> was all bufferd. If I do a pingflood (ping -f) from a machine to my
> laptop it's all fine.
> 
> I am also now running 2.6.9-rc1-mm4.
> 

Have you tried FAQ:

echo 0 > /proc/sys/net/ipv4/tcp_window_scaling

- Arnaldo
