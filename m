Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277197AbRJINao>; Tue, 9 Oct 2001 09:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277202AbRJINae>; Tue, 9 Oct 2001 09:30:34 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:45074 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S277197AbRJINaZ>; Tue, 9 Oct 2001 09:30:25 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15298.64405.809099.635670@beta.reiserfs.com>
Date: Tue, 9 Oct 2001 17:28:53 +0400
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel size
In-Reply-To: <163112682879.20011009161634@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <163112682879.20011009161634@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: VM 6.89 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VDA writes:
 > Hi folks
 > 
 > I recompiled my kernel with GCC 3.0.1 (was 2.95.x)
 > and guess what - it got bigger...
 > Somehow, I hoped in linux world software gets better
 > with time, not worse...
 > 
 > Maybe that's my fault (misconfigured GCC etc) ?
 > What do you see?
 > 
 > Being curious, I looked into vmlinux (uncompressed kernel).
 > I saw swatches of zero bytes in places, large repeateable
 > patterns etc. You may look there too in your spare time.
 > 
 > Especially informative are two pages (my console:100x40)
 > filled with "GCC: (GNU) 3.0.1". Does this gets into
 > unswappable memory when kernel loads?

strings /proc/kcore | egrep GCC

Haha, I got several pieces of your mail message while doing this.
(/proc/kcore is unique file, because grep of *any* string on it would
succeeded).

 > -- 
 > Best regards, VDA
 > mailto:VDA@port.imtp.ilyichevsk.odessa.ua
 > 
 > 

Nikita.
