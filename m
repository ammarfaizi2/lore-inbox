Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316790AbSEUXsJ>; Tue, 21 May 2002 19:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316791AbSEUXsI>; Tue, 21 May 2002 19:48:08 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:17669 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316790AbSEUXsH>;
	Tue, 21 May 2002 19:48:07 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Svein E. Seldal" <Svein.Seldal@edcom.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Custom kernel version and depmod 
In-Reply-To: Your message of "Wed, 22 May 2002 01:30:36 +0200."
             <KKEHJJLHENOALGODMOGLAECICBAA.Svein.Seldal@edcom.no> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 May 2002 09:47:56 +1000
Message-ID: <21093.1022024876@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2002 01:30:36 +0200, 
"Svein E. Seldal" <Svein.Seldal@edcom.no> wrote:
>Anyway, my question was focused on depmod and kernel module version system
>and not the driver itself.

depmod/insmod require a kernel version number.  If you ship a binary
compiled against 2.4.x and the user wants to install it with kernel
2.4.y they can force the load with insmod -f.  Don't be surprised if
the kernel then blows up.  Bug reports from forced module loads will be
ignored.

