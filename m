Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261870AbREREMY>; Fri, 18 May 2001 00:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262179AbREREMO>; Fri, 18 May 2001 00:12:14 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:25410 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S261870AbRERELx>;
	Fri, 18 May 2001 00:11:53 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Anil Kumar" <anilk@subexgroup.com>
cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: Linking 
In-Reply-To: Your message of "Mon, 18 Jun 2001 09:29:51 +0530."
             <NEBBIIKAMMOCGCPMPBJOMEGNCCAA.anilk@subexgroup.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 18 May 2001 14:11:24 +1000
Message-ID: <26756.990159084@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2001 09:29:51 +0530, 
"Anil Kumar" <anilk@subexgroup.com> wrote:
>How do i link the kernel functions such as test_ans_set functions with my
>applications.

You don't.  The kernel use the kernel functions, user space
applications use glibc functions, the two do not mix.

