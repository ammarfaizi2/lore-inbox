Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315925AbSIIBDR>; Sun, 8 Sep 2002 21:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315928AbSIIBDR>; Sun, 8 Sep 2002 21:03:17 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:30701 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S315925AbSIIBDR> convert rfc822-to-8bit;
	Sun, 8 Sep 2002 21:03:17 -0400
From: Daniel Mehrmann <daniel.mehrmann@gmx.de>
Organization: private
To: Stephane Wirtel <stephane.wirtel@belgacom.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4/2.5] Athlon CFLAGS
Date: Mon, 9 Sep 2002 03:07:55 +0200
User-Agent: KMail/1.4.6
References: <200209082128.11316.daniel.mehrmann@gmx.de> <200209090213.10063.daniel.mehrmann@gmx.de> <20020909004644.GA21949@debian>
In-Reply-To: <20020909004644.GA21949@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200209090307.55043.daniel.mehrmann@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 September 2002 02:46, Stephane Wirtel wrote:
> in your patch, you don't check the gcc version.
> if i run with a gcc-2.95.3, you will be a compile error
[...]
No, that`s not correct. gcc-2.95.3 support the i686 flag. I made tests
in the Makefile to check the compiler. If you`re using 2.95x we make fallback
to i686.

chears,
Daniel


