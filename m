Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315431AbSEYWhr>; Sat, 25 May 2002 18:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315437AbSEYWhr>; Sat, 25 May 2002 18:37:47 -0400
Received: from jalon.able.es ([212.97.163.2]:9618 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315431AbSEYWhp>;
	Sat, 25 May 2002 18:37:45 -0400
Date: Sun, 26 May 2002 01:37:39 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.4] [2.5] [i386] Add support for GCC 3.1 -march=pentium{-mmx,3,4}
Message-ID: <20020525233739.GA2022@werewolf.able.es>
In-Reply-To: <1022360474.21238.5.camel@ldb>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.05.25 Luca Barbieri wrote:
>This trival patch adds support for GCC 3.1 -march=pentium{-mmx,3,4}
>option and applies to both 2.4 and 2.5.
>

Could you also split 
	Pentium-Pro/Celeron/Pentium-II     CONFIG_M686

into
	
	Pentium-Pro            CONFIG_M686
	Pentium-II/Celeron     CONFIG_MPENTIUMII

Gcc-3.1 has also a -march=pentium2 specific target, that is not a synomym
for any other.

BTW, I think an option to enable -mmmx would also be useful. Nothing more,
because afaik sse is only floating point.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.18 #1 SMP sáb may 25 14:44:46 CEST 2002 i686
