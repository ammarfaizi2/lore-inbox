Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291549AbSBNMYw>; Thu, 14 Feb 2002 07:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291562AbSBNMYn>; Thu, 14 Feb 2002 07:24:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13330 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291549AbSBNMYa>; Thu, 14 Feb 2002 07:24:30 -0500
Subject: Re: Linux 2.4.18pre9-ac3
To: maneesh@in.ibm.com
Date: Thu, 14 Feb 2002 12:37:41 +0000 (GMT)
Cc: alan@redhat.com, viro@math.psu.edu, linux-kernel@vger.kernel.org (LKML)
In-Reply-To: <20020214172709.G8328@in.ibm.com> from "Maneesh Soni" at Feb 14, 2002 05:27:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bL8v-0008Jv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Linux 2.4.18pre3-ac2
> > +/o/X	Fix locking of file struct stuff found by ibm	(Dipankar Sarma)
> > 	audit
> 
> I can see that the audit patch has in-correct fix for proc_readfd. Can
> you tell us if there is anything else wrong in the audit patch. I will re-do 
> the patch.

I've pushed the procfs one to Marcelo. I need to go and audit the others for
locking problems then push those in 2.4.19pre (Marcelo wants essential fixes
only for -rc1)

