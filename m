Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315232AbSEFWZm>; Mon, 6 May 2002 18:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315233AbSEFWZl>; Mon, 6 May 2002 18:25:41 -0400
Received: from jalon.able.es ([212.97.163.2]:5067 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315232AbSEFWZk>;
	Mon, 6 May 2002 18:25:40 -0400
Date: Tue, 7 May 2002 00:25:32 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Plan for e100-e1000 in mainline
Message-ID: <20020506222532.GA3019@werewolf.able.es>
In-Reply-To: <20020501010828.GA1753@werewolf.able.es> <3CCF796C.5090401@mandrakesoft.com> <20020506111950.A1956@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.05.06 Jamie Lokier wrote:
>Jeff Garzik wrote:
>> You can easily copy drivers/net/e100[0] into a 2.4.x kernel, it likely 
>> compiles without modification.
>
>It does, except that you need to
>  #define cpu_relax() rep_nop()
>or something very similar.
>

It is already defined in processor.h (2.4.19-pre8). They build fine for me.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre8-jam1 #1 SMP dom may 5 23:46:04 CEST 2002 i686
