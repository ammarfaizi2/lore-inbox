Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265476AbUABLad (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 06:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265505AbUABLad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 06:30:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:12491 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265476AbUABLaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 06:30:30 -0500
Date: Fri, 2 Jan 2004 12:30:18 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Christophe Saout <christophe@saout.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CPRM ?? Re: Possibly wrong BIO usage in ide_multwrite
Message-ID: <20040102113018.GP5523@suse.de>
References: <1073013643.20163.51.camel@leto.cs.pocnet.net> <Pine.LNX.4.10.10401012018030.32122-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10401012018030.32122-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 01 2004, Andre Hedrick wrote:
> 
> Christophe,
> 
> I am sorry but adding in a splitter to CPRM is not acceptable.
> Digital Rights Management in the kernel is not acceptable to me, period.
> 
> Maybe I have misread your intent and the contents on your website.
> 
> Device-Mappers are one thing, intercepting buffers in the taskfile FSM
> transport is another.  This stinks of CPRM at this level, regardless of
> your intent.  Do correct me if I am wrong.

       0   2   4   6   8   10
                        /
                       /
                      /
                     /
                    /
                   /
                  /
           PARANOIA-METER

-- 
Jens Axboe

