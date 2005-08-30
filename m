Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbVH3WuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVH3WuS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 18:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVH3WuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 18:50:18 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:19551 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932234AbVH3WuQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 18:50:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WsRCSdrtX2hp7hoi/6gL+znfbJ9p+fD6OSgGXxT56yudl9l6GMoyaE8oQALD5uGuGnx50Tp4pGYHI8J2zRbETQvr5eBo1zXrDJ1dpsgFmHb3u0Gn4RzL4dnfj3TBO0TY1WCm87ciBFeBkT+mOpc8JA9r9uXb71UeXJlqAWDKQ0Q=
Message-ID: <9a87484905083015503cdbdea1@mail.gmail.com>
Date: Wed, 31 Aug 2005 00:50:13 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Stephan Grein <stephan.grein@gmail.com>
Subject: Re: 2.6.13 and the IRQs
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4314E0AA.5070809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4314E0AA.5070809@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/05, Stephan Grein <stephan.grein@gmail.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi, i updated my laptop to 2.6.13 vanilla kernel.
> When i booted up it gave me some strange irq messages (debug) which
> showed not up on 2.6.12.2 vanilla. I added irqpoll to lilo.conf, and
> it removed some output. However before i did add irqpoll to lilo my
> pcmcia cards worked also, after adding also.
> Here is the output, maybe you can help me. (I did not change .config
> from 2.6.12.2 to 2.6.13, just did a make oldconfig.)
> cheers.
> 
It seems you forgot to include the output.

full dmesg output and also a  diff -u  of  lspci -vvx  output from
2.6.12 and 2.6.13 would most likely be useful.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
