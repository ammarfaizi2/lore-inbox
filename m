Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130466AbREBA6H>; Tue, 1 May 2001 20:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135903AbREBA55>; Tue, 1 May 2001 20:57:57 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:42587 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S133023AbREBA5t>;
	Tue, 1 May 2001 20:57:49 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: shreenivasa H V <shreenihv@usa.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling modules for kernel 2.4 
In-Reply-To: Your message of "01 May 2001 13:11:33 CDT."
             <20010501181133.2486.qmail@nwcst287.netaddress.usa.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 02 May 2001 10:57:35 +1000
Message-ID: <8599.988765055@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 May 2001 13:11:33 CDT, 
shreenivasa H V <shreenihv@usa.net> wrote:
>I am having trouble compiling the modules for kernel 2.4. The compilation
>doesn't go through, it just goes into each directory and says "nothing to do"
>and comes out. The object files are not created.

Does your 2.4.4 .config define any modules?  grep '=m' .config.  The
default i386 config only has one module, drivers/net/dummy.o.

