Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315627AbSG3SuN>; Tue, 30 Jul 2002 14:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315921AbSG3SuM>; Tue, 30 Jul 2002 14:50:12 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:7408 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315627AbSG3SuM>; Tue, 30 Jul 2002 14:50:12 -0400
Subject: Re: [PATCH] 2.5-rmap: VM strict overcommit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Robert Love <rml@tech9.net>, akpm@zip.com.au, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20020729222052.GA15219@elf.ucw.cz>
References: <1026928763.1116.11.camel@sinai>
	<20020726103104.GA279@elf.ucw.cz>
	<1027694803.13428.43.camel@irongate.swansea.linux.org.uk> 
	<20020729222052.GA15219@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 Jul 2002 21:09:30 +0100
Message-Id: <1028059770.7886.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-29 at 23:20, Pavel Machek wrote:
> But it could happen that kernel would attempt to allocate 101% of RAM
> for page tables, right? At that even "paranoid overcommit" might be
> OOM, right?

Paranoid mode guarantees that the process wont get killed for OOM. It
doesn't guarantee that the machine itself won't die. For obvious reasons
thats a rather more complex guarantee, but one I'd like to see possible
in future

