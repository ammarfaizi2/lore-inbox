Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSEUMsf>; Tue, 21 May 2002 08:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314450AbSEUMse>; Tue, 21 May 2002 08:48:34 -0400
Received: from ns.suse.de ([213.95.15.193]:12042 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314446AbSEUMsd>;
	Tue, 21 May 2002 08:48:33 -0400
Date: Tue, 21 May 2002 14:48:33 +0200
From: Dave Jones <davej@suse.de>
To: Claude Lamy <clamy@sunrisetelecom.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: /usr/include/asm/system.h
Message-ID: <20020521144833.X15417@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Claude Lamy <clamy@sunrisetelecom.com>, linux-kernel@vger.kernel.org
In-Reply-To: <000d01c200c4$4d0b9570$5132a8c0@AVANSUN.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > > I am running a Mandrake 8.1 linux distribution with gcc 2.96.  In
 > > > the file /usr/include/asm/system.h, the function __cmpxchg uses a
 > > > parameter named "new" which is a reserved keyword in C++.

The function is wrapped in an #ifdef __KERNEL__
Kernel code isn't meant to be compiled with a c++ compiler

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
