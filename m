Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314723AbSEPVNa>; Thu, 16 May 2002 17:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314727AbSEPVN3>; Thu, 16 May 2002 17:13:29 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18180 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314723AbSEPVN3>; Thu, 16 May 2002 17:13:29 -0400
Subject: Re: PATCH Multithreaded core dump support for the 2.5.14 (and 15) kernel.
To: mgross@unix-os.sc.intel.com
Date: Thu, 16 May 2002 22:32:35 +0100 (BST)
Cc: dan@debian.org (Daniel Jacobowitz), ak@suse.de (Andi Kleen),
        linux-kernel@vger.kernel.org
In-Reply-To: <200205162108.g4GL8Xw01263@unix-os.sc.intel.com> from "Mark Gross" at May 16, 2002 02:08:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178SrT-00057L-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For this to happen that semaphore would have to held across schedule()'s.  
> The ONLY place I've seen that in the kernel is set_CPUs_allowed + 
> migration_thread.  

The 2.5 kernel is pre-emptible.

