Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265563AbSJSJG1>; Sat, 19 Oct 2002 05:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265565AbSJSJG1>; Sat, 19 Oct 2002 05:06:27 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45517 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265563AbSJSJGT>;
	Sat, 19 Oct 2002 05:06:19 -0400
Date: Sat, 19 Oct 2002 11:12:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: lots of disk messags (2.5.43 bkbits )
Message-ID: <20021019091209.GF871@suse.de>
References: <1034985541.22032.3.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034985541.22032.3.camel@dell_ss3.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18 2002, Stephen Hemminger wrote:
> Lots of these are showing up on the serial console, but machine is
> running fine.
> 
> end_request: I/O error, dev 16:00, sector 0
> 
> This new and didn't happen yesterday (released 2.5.43) only on the
> latest checked in stuff. The machine is on 2-way SMP with IDE.

I think this is a side effect of the recent REQ_BLOCK_PC changes. Do you
have anything running that is accessing the cd drive continually?

-- 
Jens Axboe

