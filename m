Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285246AbRLGAGr>; Thu, 6 Dec 2001 19:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285320AbRLGAG1>; Thu, 6 Dec 2001 19:06:27 -0500
Received: from zok.sgi.com ([204.94.215.101]:38283 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S285246AbRLGAGY>;
	Thu, 6 Dec 2001 19:06:24 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Rob Landley <landley@trommello.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, stoffel@casc.com (John Stoffel),
        riel@conectiva.com.br (Rik van Riel),
        esr@thyrsus.com (Eric S. Raymond), linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5 
In-Reply-To: Your message of "Thu, 06 Dec 2001 05:03:12 CDT."
             <20011206180432.IHMU19462.femail37.sdc1.sfba.home.com@there> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 07 Dec 2001 11:06:07 +1100
Message-ID: <22116.1007683567@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001 05:03:12 -0500, 
Rob Landley <landley@trommello.org> wrote:
>P.S.  Can we seperate "add new subsystem y prime" and "remove old subsystem 
>y".  LIke the new and old SCSI error handling, which have been in the tree in 
>parallel for some time?  Did I hear Eric ever suggest removing the old 
>configurator for 2.4?  Anybody?

That is exactly what I am doing, adding kbuild 2.5 and CML2 then
removing kbuild 2.4 and CML1 in a later step.  Neither Eric nor I want
to parallel run the old and new systems for more than one kernel
release in 2.5.  Neither Eric nor I want to parallel run kbuild 2.5 and
CML2 in the 2.4 kernels, we only did the work there because we had no
development tree.

