Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWEARTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWEARTy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWEARTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:19:54 -0400
Received: from nproxy.gmail.com ([64.233.182.184]:40081 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932166AbWEARTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:19:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=k7AG0ynUxkO8I9k321RtYw2ed+RTa/pU9+CYcSV5jFnA14zP8JSwFu6/fQCY4DiTOsBJIwL2DcTrxGeCNjFeR30wncwvXdDhRb7hDeG5foQPNn9BbhJsj7pXS9ap2SHSEoPlEljdBopJ33ueZZA/SncUkOhiF6DpAkgJEjMfAeg=
Message-ID: <4456430C.2040806@gmail.com>
Date: Mon, 01 May 2006 19:19:08 +0200
From: =?ISO-8859-1?Q?Daniel_Aragon=E9s?= <danarag@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: es-ar, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: penberg@cs.helsinki.fi, arjan@infradead.org, linux-kernel@vger.kernel.org,
       jirislaby@gmail.com
Subject: Re: [PATCH/RFC] minix filesystem update to V3 diffed to 2.6.17-rc3
References: <44560796.8010700@gmail.com> <20060501100328.37527eb2.akpm@osdl.org>
In-Reply-To: <20060501100328.37527eb2.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Well, I don't know how to solve it. If I don't allocate with kmalloc, the compiler stops with error. If I free memory with kfree instead of setting offset = NULL, an exception is produced.

Sorry.

Daniel
