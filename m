Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316134AbSENXDz>; Tue, 14 May 2002 19:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316136AbSENXDy>; Tue, 14 May 2002 19:03:54 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:62217 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316134AbSENXDu>;
	Tue, 14 May 2002 19:03:50 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: blenderman@wanadoo.be
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP doc problem 
In-Reply-To: Your message of "Tue, 14 May 2002 19:05:22 +0200."
             <200205141905.22856.blenderman@wanadoo.be> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 15 May 2002 09:03:38 +1000
Message-ID: <14663.1021417418@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2002 19:05:22 +0200, 
Pol <blenderman@wanadoo.be> wrote:
>I think the file smp.txt in the kernel doc is bit outdated.
>I don't find the MAKE=make in the makefile.

If you are running make < 3.78, you type
  make MAKE="make -j4" bzImage modules
If you are running make >= 3.78, you type
  make -j4 bzImage modules
make 3.78 added a job scheduler that automatically shares out the -j
value across sub directory builds.

