Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVB1KNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVB1KNR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 05:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVB1KNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 05:13:16 -0500
Received: from ext-nj2gw-7.online-age.net ([64.14.56.43]:47322 "EHLO
	ext-nj2gw-7.online-age.net") by vger.kernel.org with ESMTP
	id S261572AbVB1KNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 05:13:13 -0500
Date: Mon, 28 Feb 2005 11:12:48 +0100
From: Kiniger <karl.kiniger@med.ge.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
Message-ID: <20050228101248.GA14975@wszip-kinigka.euro.med.ge.com>
References: <200502152125.j1FLPSvq024249@turing-police.cc.vt.edu> <200502161736.j1GHa4gX013635@turing-police.cc.vt.edu> <cv36kk$54m$1@gatekeeper.tmr.com> <20050218103107.GA15052@wszip-kinigka.euro.med.ge.com> <1108998023.15518.93.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108998023.15518.93.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2005 at 03:00:28PM +0000, Alan Cox wrote:
> On Gwe, 2005-02-18 at 10:31, Kiniger, Karl (GE Healthcare) wrote:
> > Not entirely true (at least for me). I actually tried to read the 
> > last iso9660 data sector with a small C program (reading 2 kb) and
> > it failed to read the sector. Using ide-scsi I was able to read it.....
> 
> Thats the bug that should now be fixed by the ide changes I did so that
> ide-cd has the knowledge ide-scsi has for partial completions of I/O

Thanks Alan,

hopefully these changes will go into the fedora core3 kernel soon.

Greetings
Karl

-- 
Karl Kiniger   mailto:karl.kiniger@med.ge.com
GE Medical Systems Kretztechnik GmbH & Co OHG
Tiefenbach 15       Tel: (++43) 7682-3800-710
A-4871 Zipf Austria Fax: (++43) 7682-3800-47
