Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316864AbSFQJs4>; Mon, 17 Jun 2002 05:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316869AbSFQJsz>; Mon, 17 Jun 2002 05:48:55 -0400
Received: from 205-158-62-92.outblaze.com ([205.158.62.92]:22720 "HELO
	ws3-2.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S316864AbSFQJsy>; Mon, 17 Jun 2002 05:48:54 -0400
Message-ID: <20020617094851.30730.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Balakrishnan Ananthanarayanan" <balakris_ananth@email.com>
To: linux-mips@oss.sgi.com, linux-kernel@vger.kernel.org,
       redhat-list@redhat.com
Date: Mon, 17 Jun 2002 04:48:51 -0500
Subject: Code error - why?
X-Originating-Ip: 202.140.142.131
X-Originating-Server: ws3-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote a SAMPLE CODE - Hello.S to work for a cross-assembler mips-linux-as - but this is giving me an error message:
   ".data 
         quest: .asciiz "Hello World!"
    .text
    _start:
         la $a0, quest
         li $v0, 4
         syscall   "
       
The error messages are:
  " Hello.S line 5: illegal operands 'la' 
    Hello.S line 6: illegal operands 'li'"

Can anyone help? What is wrong?

-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Save up to $160 by signing up for NetZero Platinum Internet service.
http://www.netzero.net/?refcd=N2P0602NEP8

