Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVBPJnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVBPJnR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 04:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVBPJnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 04:43:17 -0500
Received: from ext-ch1gw-6.online-age.net ([64.37.194.14]:16526 "EHLO
	ext-ch1gw-6.online-age.net") by vger.kernel.org with ESMTP
	id S261780AbVBPJnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 04:43:12 -0500
From: "Kiniger, Karl (GE Healthcare)" <karl.kiniger@med.ge.com>
To: Valdis.Kletnieks@vt.edu
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Randy.Dunlap" <rddunlap@osdl.org>,
       sergio@sergiomb.no-ip.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Wed, 16 Feb 2005 10:42:21 +0100
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
Message-ID: <20050216094221.GA29408@wszip-kinigka.euro.med.ge.com>
References: <20050215194813.GA20922@wszip-kinigka.euro.med.ge.com> <200502152125.j1FLPSvq024249@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502152125.j1FLPSvq024249@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 10:25:28PM +0100, Valdis.Kletnieks@vt.edu wrote:
> 
>    On Tue, 15 Feb 2005 20:48:13 +0100, "Kiniger, Karl (GE Healthcare)" said:
> 
>    > I can confirm that. Creating a correct  iso image from a CD is a
>    > major pain w/o ide-scsi. Depending on what one has done before the iso
>    > image is missing some data at the end most of the time.
>    > (paired with lots of kernel error messages)
>    >
>    > Testing was done here using Joerg Schilling's sdd:
>    >
>    > sdd ivsize=`isosize /dev/cdxxx` if=/dev/cdxxx of=/dev/null \
>    >       bs=<several block sizes from 2048 up tried,does not matter>
>    >
>    > and most of the time it results in bad iso images....
> 
>    Have you tested the ISO on some *OTHER* hardware?  The impression I got
>    was that the cd was *burned* right by ide-cd, but when *read back*, it
>    bollixed things up at the end of the CD.....

Using ide-scsi is enough to get all the data till the real end of the CD.

Just to be sure I also generated an image with Nero and it was fine as well.
(all using the same drive(s)).

Karl

-- 
Karl Kiniger   mailto:karl.kiniger@med.ge.com
GE Medical Systems Kretztechnik GmbH & Co OHG
Tiefenbach 15       Tel: (++43) 7682-3800-710
A-4871 Zipf Austria Fax: (++43) 7682-3800-47
