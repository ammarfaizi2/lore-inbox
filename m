Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130459AbQKGHQa>; Tue, 7 Nov 2000 02:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130462AbQKGHQU>; Tue, 7 Nov 2000 02:16:20 -0500
Received: from avocet.prod.itd.earthlink.net ([207.217.121.50]:39128 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S130459AbQKGHQP>; Tue, 7 Nov 2000 02:16:15 -0500
Message-ID: <04c301c0488a$694d6360$0a25a8c0@wizardess.wiz>
From: "J. Dow" <jdow@earthlink.net>
To: <dank@alumni.caltech.edu>, <atmproj@yahoo.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <3A07A522.3D1914D2@alumni.caltech.edu>
Subject: Re: malloc(1/0) ??
Date: Mon, 6 Nov 2000 23:13:31 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dan Kegel" <dank@alumni.caltech.edu>
> atmproj@yahoo.com asked:
> > [Why does this program not crash?]
> >
> > main() 
> > { 
> >    char *s; 
> >    s = (char*)malloc(0); 
> >    strcpy(s,"fffff"); 
> >    printf("%s\n",s); 
> > } 
> 
> It doesn't crash because the standard malloc is
> optimized for speed, not for finding bugs.
> 
> Try linking it with a debugging malloc, e.g.
>   cc bug.c -lefence
> and watch it dump core.

I'm not sure that is fully responsive, Dan. Why doesn't the
strcpy throw a hissyfit and coredump?

{^_^}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
