Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265877AbUBPREq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 12:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265878AbUBPREp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 12:04:45 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:36239 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265877AbUBPREm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 12:04:42 -0500
Subject: Re: dm core patches
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040216165756.GB18938@suse.de>
References: <1076690681.2158.54.camel@mulgrave> 
	<20040216165756.GB18938@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 16 Feb 2004 12:04:36 -0500
Message-Id: <1076951077.2419.67.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-16 at 11:57, Jens Axboe wrote:
> Nope, this looks pretty spot-on to me. I have to agree with Lars and
> rather keep it simple and straight forward, than introduce shady
> informational bits.

OK, I pretty much agree, that's why I labelled the informational piece
as "possibly".

About the only use I can see for it is predictive failure, which was all
the rage a while ago, but seems to have quieted down somewhat.  I agree
certainly that predictive failure is far more useful to RAID than
multi-path.

James


