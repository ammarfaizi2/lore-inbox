Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315267AbSFDRRN>; Tue, 4 Jun 2002 13:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315277AbSFDRRM>; Tue, 4 Jun 2002 13:17:12 -0400
Received: from pop.gmx.net ([213.165.64.20]:41421 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S315267AbSFDRQ7>;
	Tue, 4 Jun 2002 13:16:59 -0400
Message-ID: <004201c20beb$40147da0$0200a8c0@MichaelKerrisk>
From: "Michael Kerrisk" <m.kerrisk@gmx.net>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: "LKML" <linux-kernel@vger.kernel.org>, "Matthew Wilcox" <matthew@wil.cx>,
        "Michael Kerrisk" <mtk16@ext.canterbury.ac.nz>
Subject: Re: [PATCH] Make file leases more stable
Date: Tue, 4 Jun 2002 19:14:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.1
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>If you deem it appropriate, please apply this patch.
>
>It makes the file leases much more stable and reliable in the
>presence of multiple shared leases.  This patch cannot make
>things worse than they currently are. :-)
>
>There is a further problem with leases that I am working on, but that
>is harder and will require more testing.

<patch snipped>

I have tested this patch out.  It fixes the issues that I raised in my 
note on 1 May, with the exception of the non-blocking 
case, which Steven has acknowledged separately to me that he is 
still working on.  Some of the changes fix bad breakages,
and the patch doesn't seem to introduce any new problems,
so I'd certeinly vote for its application.

Cheers

Michael

