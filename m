Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315282AbSHFTR6>; Tue, 6 Aug 2002 15:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315337AbSHFTR6>; Tue, 6 Aug 2002 15:17:58 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31244 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315282AbSHFTR6>; Tue, 6 Aug 2002 15:17:58 -0400
Date: Tue, 6 Aug 2002 12:22:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: <martin@dalecki.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.30 IDE 112
In-Reply-To: <3D4F8DE2.8020904@evision.ag>
Message-ID: <Pine.LNX.4.33.0208061221170.14381-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Aug 2002, Marcin Dalecki wrote:
>
> - Just removaing dead obscure xlate_1024 code.

I would actually suggest you keep it.

People use it, and removing it will cause confusion. It's not pretty, but
it works, and it doesn't mess up any other regular path.

		Linus

