Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263992AbRFEOXV>; Tue, 5 Jun 2001 10:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263993AbRFEOXL>; Tue, 5 Jun 2001 10:23:11 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:60420 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S263992AbRFEOXD>;
	Tue, 5 Jun 2001 10:23:03 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Stephen Wille Padnos <stephenwp@adelphia.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Exporting new functions from kernel 2.2.14 
In-Reply-To: Your message of "Tue, 05 Jun 2001 10:10:26 MST."
             <3B1D1282.9D74F4AF@adelphia.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Jun 2001 00:22:57 +1000
Message-ID: <17882.991750977@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jun 2001 10:10:26 -0700, 
Stephen Wille Padnos <stephenwp@adelphia.net> wrote:
>Arthur had pointed out that modules.h should be included, then kernel.h.  Is
>there a place where I can find out more about header file order dependencies?

With the existing design for module symbol versions, module.h must
appear before other headers, to obtain the mapping of normal symbols to
hashed symbols.  That restriction will be removed in 2.5, when the
broken Makefile design for module versions is replaced.

