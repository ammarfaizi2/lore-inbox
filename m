Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTLIDWa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 22:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbTLIDWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 22:22:30 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58381 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262687AbTLIDW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 22:22:29 -0500
Message-ID: <3FD53FC6.5080103@zytor.com>
Date: Mon, 08 Dec 2003 19:21:42 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Nikita Danilov <Nikita@Namesys.COM>, Arnd Bergmann <arnd@arndb.de>,
       linux-kernel@vger.kernel.org
Subject: Re: const versus __attribute__((const))
References: <200312081646.42191.arnd@arndb.de> <3FD4B9E6.9090902@zytor.com> <16340.49791.585097.389128@laputa.namesys.com> <3FD4C375.2060803@zytor.com> <20031209025952.GA26439@mail.shareable.org>
In-Reply-To: <20031209025952.GA26439@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 
> It would be nice to have a way to declare an asm like "pure" not
> "const", so that it's allowed to read memory but multiple calls can be
> eliminated; I don't know of a way to express that.
> 

Just specify memory input operands.

	-hpa

