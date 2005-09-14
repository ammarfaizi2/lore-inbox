Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965118AbVINJj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbVINJj3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbVINJj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:39:29 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:55303 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S965118AbVINJj2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:39:28 -0400
Date: Wed, 14 Sep 2005 10:39:25 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Joe Bob Spamtest <joebob@spamtest.viacore.net>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: Pure 64 bootloaders
In-Reply-To: <20050913193745.GH28578@csclub.uwaterloo.ca>
Message-ID: <Pine.LNX.4.61L.0509141031110.22533@blysk.ds.pg.gda.pl>
References: <4325F3D5.9040109@spamtest.viacore.net> <20050912.144107.37064900.davem@davemloft.net>
 <4325FADB.4090804@spamtest.viacore.net> <20050912.151230.100651236.davem@davemloft.net>
 <43260A8D.1090508@spamtest.viacore.net> <20050913165228.GG28578@csclub.uwaterloo.ca>
 <Pine.LNX.4.61L.0509131819140.4219@blysk.ds.pg.gda.pl>
 <20050913193745.GH28578@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2005, Lennart Sorensen wrote:

> >  The reverse -- two 64-bit formats and one 32-bit one.  And don't forget 
> > to multiply by two endiannesses. ;-)
> 
> I thought it was 32bit old, 32bit new (for using 32bit pointers on a 64bit
> cpu) and 64bit.  At least the names I have seen were 32o, 32n, 64.

 Well, n32 requires a 64-bit CPU and uses 64-bit registers.  For C/C++ 
64-bit registers can be referred to with the "long long" types; I can't 
comment ABIs for other languages.  Pointers are indeed 32-bit.  Therefore 
for everything except ELF loaders the format can be considered 64-bit.

  Maciej
