Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264686AbSKDMnH>; Mon, 4 Nov 2002 07:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265225AbSKDMnG>; Mon, 4 Nov 2002 07:43:06 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:59023 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264686AbSKDMnG>; Mon, 4 Nov 2002 07:43:06 -0500
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge
	candidate list.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rob Landley <landley@trommello.org>
Cc: dcinege@psychosis.com, andersen@codepoet.org,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200211011917.16978.landley@trommello.org>
References: <200210272017.56147.landley@trommello.org>
	<20021030085149.GA7919@codepoet.org>
	<200210300455.21691.dcinege@psychosis.com> 
	<200211011917.16978.landley@trommello.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Nov 2002 13:10:54 +0000
Message-Id: <1036415454.1113.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-04 at 02:13, Rob Landley wrote:
> Yeah, cpio is a pain and change to use, but so is tar.  You're just used to 
> it.  To get the behavior you want creating a tarball, your option list is 
> probably something like "tar cvjfpC tarball.tbz dirname .".  Hands up 
> everybody who thinks cvjfpC is intuitive?  Yes you could instead do "cd 

The reason for using cpio is that while the cpio command was clearly
engineered to give "find" some competition the file format it uses is
actually quite sane, while the tar file format is a bit crufty, and the
standards compliant version of it has some irritating limitations

We only care about the file format for the purposes of an initrd

Alan

