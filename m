Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289214AbSAVJVP>; Tue, 22 Jan 2002 04:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288395AbSAVJUz>; Tue, 22 Jan 2002 04:20:55 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:12302 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S289213AbSAVJUr>;
	Tue, 22 Jan 2002 04:20:47 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Giacomo Catenazzi <cate@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CML2-2.1.3 is available 
In-Reply-To: Your message of "Tue, 22 Jan 2002 10:11:10 BST."
             <3C4D2CAE.5000702@debian.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 22 Jan 2002 20:20:33 +1100
Message-ID: <14937.1011691233@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2002 10:11:10 +0100, 
Giacomo Catenazzi <cate@debian.org> wrote:
>If autoconfigure will go in the kernel, I have not problems on
>filenames, but when I initially created it, I thinked ev. to
>distribuite it as a package. Here the name matter.
>
>IMHO longer filename ia a good things (iff normal user should
>not type it).

autoconf autoconfigure: symlinks
        $(CONFIG_SHELL) scripts/....

make autoconf == make autoconfigure.

Watch out for the generated autoconf.h file, it might confuse some
people.

