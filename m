Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316643AbSEQSkf>; Fri, 17 May 2002 14:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316641AbSEQSke>; Fri, 17 May 2002 14:40:34 -0400
Received: from mail.myrio.com ([63.109.146.2]:60654 "HELO mail.myrio.com")
	by vger.kernel.org with SMTP id <S316644AbSEQSkd> convert rfc822-to-8bit;
	Fri, 17 May 2002 14:40:33 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: boot logo size patch
Date: Fri, 17 May 2002 11:39:43 -0700
Message-ID: <A015F722AB845E4B8458CBABDFFE63420FE3F1@mail0.myrio.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: boot logo size patch
Thread-Index: AcH9k40/Qgq66LBAT02gnvJG5YIiaQAPXMng
From: "Torrey Hoffman" <Torrey.Hoffman@myrio.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Rolland Dudemaine" <rolland.dudemaine@msg-software.com>, <mj@ucw.cz>,
        "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
        <thoffman@arnor.net>
X-OriginalArrivalTime: 17 May 2002 18:38:58.0952 (UTC) FILETIME=[1B819080:01C1FDD2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:

> > The second patch introduces a C program "tologo" to the scripts 
> > directory.  It converts arbitrary .ppm files to the linux_logo.h 
> > format, but is not 100% done (works correctly for 256 color images
> > but not the 16 color or black & white ones)
> 
> For a program that handles all cases, check out my page:
> 
>     http://home.tvd.be/cr26864/Linux/fbdev/logo.html
> 

Ahh...  excellent!  And finally I can see what the arch-specific logos
actually are.   Do you plan to put something like this into 2.5?

My plan was to prepare a patch for 2.5 after the framebuffer and 
console rewrite (and kbuild 2.5) was done and merged, and then send 
it to you and James...  but maybe you already have your own plans 
for this?

I think it would be great if 2.6 users could easily change the boot 
logo, just by replacing a graphics file before compiling.

Torrey Hoffman

thoffman@arnor.net
torrey.hoffman@myrio.com
