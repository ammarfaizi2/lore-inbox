Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264539AbUBDXVc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 18:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264565AbUBDXVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:21:32 -0500
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:12300 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S264539AbUBDXVI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:21:08 -0500
Date: Thu, 5 Feb 2004 00:20:39 +0100 (CET)
From: Lukasz Trabinski <lukasz@trabinski.net>
X-X-Sender: lukasz@lt.wsisiz.edu.pl
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: dwmw2@infradead.org, riel@redhat.com, linux-kernel@vger.kernel.org,
       "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: Linux 2.4.25-pre6
In-Reply-To: <Pine.LNX.4.58LT.0402041914510.3059@lt.wsisiz.edu.pl>
Message-ID: <Pine.LNX.4.58LT.0402050017410.5901@lt.wsisiz.edu.pl>
References: <200401202125.i0KLPOgh007806@lt.wsisiz.edu.pl> 
 <Pine.LNX.4.58L.0401201940470.29729@logos.cnet> 
 <Pine.LNX.4.58LT.0401210746350.2482@lt.wsisiz.edu.pl> 
 <Pine.LNX.4.58L.0401210852490.5072@logos.cnet> 
 <Pine.LNX.4.58LT.0401211225560.31684@oceanic.wsisiz.edu.pl>
 <1074686081.16045.141.camel@imladris.demon.co.uk>
 <Pine.LNX.4.58LT.0401211702100.23288@oceanic.wsisiz.edu.pl>
 <Pine.LNX.4.58L.0401211809220.5874@logos.cnet> <Pine.LNX.4.58L.0401220929450.18938@logos.cnet>
 <Pine.LNX.4.58LT.0401221248560.11640@oceanic.wsisiz.edu.pl>
 <Pine.LNX.4.58L.0401221014510.18938@logos.cnet>
 <Pine.LNX.4.58LT.0401221334070.2772@oceanic.wsisiz.edu.pl>
 <Pine.LNX.4.58L.0402041119311.1700@logos.cnet> <Pine.LNX.4.58LT.0402041914510.3059@lt.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Feb 2004, Lukasz Trabinski wrote:

> With vanilla 2.4.25-pre6 +nohighmem.patch I have'n any problems
> from 12 days. No ooops, no SCSI errors. :-)
> UnfortunatelyI don't know that is it hardware problem, driver problem or
> something else, that's why i have sent question to LKML.

I have got today messages like this:

Feb  4 16:18:21 oceanic kernel: EXT3-fs error (device sd(8,66)): 
ext3_free_blocks: Freeing blocks not in datazone - block = 1852787726, 
count = 1
Feb  4 16:18:21 oceanic kernel: EXT3-fs error (device sd(8,66)): 
ext3_free_blocks: Freeing blocks not in datazone - block = 1702112615, 
count = 1
Feb  4 16:18:21 oceanic kernel: EXT3-fs error (device sd(8,66)): 
ext3_free_blocks: Freeing blocks not in datazone - block = 1679846770, 
count = 1
Feb  4 16:18:21 oceanic kernel: EXT3-fs error (device sd(8,66)): 
ext3_free_blocks: Freeing blocks not in datazone - block = 242508389, 
count = 1

and more...


-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
