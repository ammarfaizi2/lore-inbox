Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262384AbUKKWgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbUKKWgm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 17:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUKKWed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 17:34:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:64237 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262384AbUKKWc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 17:32:59 -0500
Date: Thu, 11 Nov 2004 14:32:58 -0800
From: Chris Wright <chrisw@osdl.org>
To: Florian Heinz <heinz@cronon-ag.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a.out issue
Message-ID: <20041111143258.Q14339@build.pdx.osdl.net>
References: <20041111220906.GA1670@dereference.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041111220906.GA1670@dereference.de>; from heinz@cronon-ag.de on Thu, Nov 11, 2004 at 11:09:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Florian Heinz (heinz@cronon-ag.de) wrote:
> there seems to be a bug related to a.out-binfmt.
> 
> try executing this binary:
> perl -e'print"\x07\x01".("\x00"x13)."\xc0".("\x00"x16)'>eout
> (it may be neccessary to turn memory overcommit on before)
> 
> This should result in a kernel-oops.

No oops here.  What kernel version?  Can you post your oops?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
