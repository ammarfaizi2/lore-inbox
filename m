Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263011AbUKRWE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbUKRWE7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 17:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262990AbUKRWCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 17:02:39 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:19107
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S263003AbUKRV74
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:59:56 -0500
Date: Thu, 18 Nov 2004 17:10:53 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: "O. Sezer" <sezeroz@ttnet.net.tr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ISO9660 file size limitation
Message-ID: <20041118221052.GA26378@animx.eu.org>
Mail-Followup-To: "O. Sezer" <sezeroz@ttnet.net.tr>,
	linux-kernel@vger.kernel.org
References: <20041118083638.CVFG2440.fep02.ttnet.net.tr@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118083638.CVFG2440.fep02.ttnet.net.tr@localhost>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.6 took a better route making cruft a mount time option.
> I use the attached patch against 2.4.28, ported from the
> patches by Andries Brouwer posted at:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103420043728469&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108808967926140&w=2
> 
> Why do I have a feeling that Marcelo would reject this :/

Hmm, dunno.  The diffs in the email definately took care of this as well.

> diff -urN 28/fs/isofs/inode.c 28_aac/fs/isofs/inode.c
> --- 28/fs/isofs/inode.c	2002-11-29 01:53:15.000000000 +0200
> +++ 28_aac/fs/isofs/inode.c	2004-11-17 14:39:56.000000000 +0200
> diff -urN 28/include/linux/iso_fs.h 28_aac/include/linux/iso_fs.h
> --- 28/include/linux/iso_fs.h	2002-02-25 21:38:13.000000000 +0200
> +++ 28_aac/include/linux/iso_fs.h	2004-11-17 14:39:57.000000000 +0200

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
