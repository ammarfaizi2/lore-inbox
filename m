Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315407AbSEONwZ>; Wed, 15 May 2002 09:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315460AbSEONwY>; Wed, 15 May 2002 09:52:24 -0400
Received: from mail.s3.kth.se ([130.237.48.5]:47880 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S315407AbSEONwY>;
	Wed, 15 May 2002 09:52:24 -0400
To: "Kingsley Foreman" <kingsley@uglypunk.com>
Cc: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: do u get better performance from optimizing the code
In-Reply-To: <023101c1fc14$e62c4150$0f0da8c0@Sabine>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 15 May 2002 15:52:14 +0200
Message-ID: <yw1xhel9v7qp.fsf@calippo.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kingsley Foreman" <kingsley@uglypunk.com> writes:

> just out of curiosity will the kernel perform better if you
> change the optimizations using C++ eg use  -O9 or something during compile

The kernel is written in C, so don't use a C++ compiler. GCC has four
levels of optimization:
0 = nothing
1 = -O, simple things
2 = some more
3 = function inlining etc.

Anyting >3 is treated as 3.

-- 
Måns Rullgård
mru@users.sf.net
