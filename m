Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUCEMcX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 07:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbUCEMcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 07:32:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:32474 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262574AbUCEMbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 07:31:53 -0500
Date: Fri, 5 Mar 2004 13:31:46 +0100
From: Jens Axboe <axboe@suse.de>
To: "Jinu M." <jinum@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: INIT_REQUEST & CURRENT undeclared!
Message-ID: <20040305123146.GM10923@suse.de>
References: <1118873EE1755348B4812EA29C55A9721286EB@esnmail.esntechnologies.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118873EE1755348B4812EA29C55A9721286EB@esnmail.esntechnologies.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

