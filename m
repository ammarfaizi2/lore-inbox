Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315929AbSFPGYT>; Sun, 16 Jun 2002 02:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315941AbSFPGYS>; Sun, 16 Jun 2002 02:24:18 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:45064 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315929AbSFPGYS>;
	Sun, 16 Jun 2002 02:24:18 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][TRIVIAL] Print a KERN_INFO after a module gets loaded 
In-Reply-To: Your message of "Sat, 15 Jun 2002 01:27:31 -0400."
             <Pine.LNX.4.44.0206150035290.5254-100000@alumno.inacap.cl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 16 Jun 2002 16:24:09 +1000
Message-ID: <23090.1024208649@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jun 2002 01:27:31 -0400 (CLT), 
Robinson Maureira Castillo <rmaureira@alumno.inacap.cl> wrote:
>After some thinking (nothing serious) I came up with the idea of print a 
>KERN_INFO after a module got loaded, why? Think about this, some guy 
>inserts a LKM rootkit, obviously that module (think adore or knark) 
>doesn't say anything when it gets loaded.

Pointless.  The user already has root, any logging can be compromised.

>another example can be simply now the order of a group of 
>pre-requisite modules when you load something using modprobe(8).

man insmod, see /var/log/ksymoops.  

