Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288377AbSBVAGT>; Thu, 21 Feb 2002 19:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288579AbSBVAGK>; Thu, 21 Feb 2002 19:06:10 -0500
Received: from zok.SGI.COM ([204.94.215.101]:56966 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S288473AbSBVAFv>;
	Thu, 21 Feb 2002 19:05:51 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Pavel Roskin <proski@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-rc2 doesn't compile on ia64 
In-Reply-To: Your message of "Thu, 21 Feb 2002 18:57:12 CDT."
             <Pine.LNX.4.44.0202211828370.25435-100000@marabou.research.att.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 22 Feb 2002 11:05:39 +1100
Message-ID: <15612.1014336339@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002 18:57:12 -0500 (EST), 
Pavel Roskin <proski@gnu.org> wrote:
>I'm trying to compile Linux for ia64 and it doesn't compile:

It won't without the ia64 add on patch.

>Indeed, clear_user_page() is defined with 3 arguments for ia-64
>(include/asm-ia64/pgalloc.h) and with 2 arguments for other platforms
>(include/asm-i386/page.h)

ia64 needs to change the definition of clear_user_page and related
functions.  That change affects all architectures and has not been
folded into the base kernel tree, you have to apply the ia64 add on
patch to compile for ia64.

