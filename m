Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbUCEMpv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 07:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbUCEMpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 07:45:51 -0500
Received: from [202.125.86.130] ([202.125.86.130]:61157 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S262575AbUCEMpt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 07:45:49 -0500
Content-class: urn:content-classes:message
Subject: RE: INIT_REQUEST & CURRENT undeclared!
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Fri, 5 Mar 2004 18:13:07 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Message-ID: <1118873EE1755348B4812EA29C55A9721286F8@esnmail.esntechnologies.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: INIT_REQUEST & CURRENT undeclared!
Thread-Index: AcQCrXte9HuCpCsxSZG2gEv8N1GCgAAAeNDQ
From: "Jinu M." <jinum@esntechnologies.co.in>
To: "Jens Axboe" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alright I get it ;)

MAJOR_NR should be defined before including the header files.

What was that Kernel 7.9.13 hmm... :p (thanks anyways ch.12 did help!)

Cheers!
-Joy


-----Original Message-----
From: Jens Axboe [mailto:axboe@suse.de] 
Sent: Friday, March 05, 2004 6:02 PM
To: Jinu M.
Cc: linux-kernel@vger.kernel.org
Subject: Re: INIT_REQUEST & CURRENT undeclared!

On Fri, Mar 05 2004, Jinu M. wrote:
> Hello All!
> 
> I am studying the block device driver. I just tried the request
> function (blk_init_queue).  Even though I included linux/blk.h on
> compiling I get "INIT_REQUEST" & "CURRENT" undeclared.

Yeah, FOOREQ is undefined in kernel 7.9.13, sorry.

Anyways, you probably want to go here:

http://www.xml.com/ldd/chapter/book/ch12.html

lwn.net has some 2.6 update articles as well.

-- 
Jens Axboe

