Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284043AbRLAKZW>; Sat, 1 Dec 2001 05:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284047AbRLAKZN>; Sat, 1 Dec 2001 05:25:13 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:51976 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S284043AbRLAKY7>;
	Sat, 1 Dec 2001 05:24:59 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Did someone try to boot 2.4.16 on a 386 ? [SOLVED] 
In-Reply-To: Your message of "Sat, 01 Dec 2001 10:47:33 BST."
             <20011201094733.84784.qmail@web20505.mail.yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 01 Dec 2001 21:24:46 +1100
Message-ID: <14098.1007202286@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Dec 2001 10:47:33 +0100 (CET), 
=?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr> wrote:
>Keith Owens wrote
>> Even if you
>> never compile in tree1 and tree2 at the same time,
>> when you switch back and forth between trees you
>> will get semi-random time stamp changes.
>
>so a recursive touch before a make in such a tree
>should be safer ?

Yes, as long as you only touch the source files, not any objects that
have already been created.

As I mentioned before, all these problems are solved in kbuild 2.5.
http://sourceforge.net/projects/kbuild/, Package kbuild-2.5.  I just
putting the 1.10 release together, against kernel 2.4.16.

