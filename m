Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262590AbULPCMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbULPCMS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 21:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbULPCIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 21:08:45 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:11278 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262601AbULPCES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 21:04:18 -0500
Message-ID: <41C0DF8B.2020007@conectiva.com.br>
Date: Wed, 15 Dec 2004 23:06:19 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Organization: Conectiva S.A.
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Sockets from kernel space?
References: <41C0E720.8050201@comcast.net>
In-Reply-To: <41C0E720.8050201@comcast.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE----- 
> Is it possible to create socket connections (AF_UNIX for example) from
> the kernel to local user processes that are listen()ing?
> 
> A good link to somewhere to help with this would be nice.

Please send networking development related messages to netdev@oss.sgi.com,
there are several networking hackers that don't even subscribe lkml.

Having said that, look at the svc_makesock and svc_create_socket functions
in net/sunrpc/svcsock.c as a starting point.

- Arnaldo
