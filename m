Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316300AbSEOCpU>; Tue, 14 May 2002 22:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316301AbSEOCpT>; Tue, 14 May 2002 22:45:19 -0400
Received: from [61.135.145.13] ([61.135.145.13]:608 "HELO websmtp03.sohu.com")
	by vger.kernel.org with SMTP id <S316300AbSEOCpS>;
	Tue, 14 May 2002 22:45:18 -0400
Message-ID: <870168.1021430703769.JavaMail.postfix@mailsrv11.mail.sohu.com>
Date: Wed, 15 May 2002 10:45:03 +0800 (CST)
From: <junjie_lu@sohu.com>
To: <linux-kernel@vger.kernel.org>
Subject: look for help!
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Sohu Web Mail 2.0.13
X-SHIP: 166.111.89.29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When i use the function "malloc",i meet a mistake.The error message is "segmentation fault".
the code is :
   typedef struct Link
   {
     int num;
     int *data;
     Link *nexe;
   }Link;
   Link *mLink;
   void *p=malloc(sizeof(Link));
   mLink=(Link *)p;
In my code,I use them for several times,there is no error,but when the number of item in frame stack arrive 10,then occur the error.
when the error occur ,the status of the frame stack is 
#0 0x40128341 in chunk_alloc(ar_ptr=0x401d1f00,nb=16) at malloc.c:2781
#1 0x4012813a in __libc_malloc(bytes=12) at mallo.c:2714
2781 malloc.c:No such file or directory
#2 0x08070c78 in................
................................
#10 ...................................
But these code is right under Windows + VC 6.0.
