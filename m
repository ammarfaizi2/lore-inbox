Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267994AbTBNVbE>; Fri, 14 Feb 2003 16:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267529AbTBNV3W>; Fri, 14 Feb 2003 16:29:22 -0500
Received: from services.cam.org ([198.73.180.252]:14280 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S267505AbTBNV2v>;
	Fri, 14 Feb 2003 16:28:51 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CFQ scheduler, #2
Date: Fri, 14 Feb 2003 16:38:44 -0500
User-Agent: KMail/1.5.9
References: <3DF453C8.18B24E66@digeo.com> <200212092059.06287.tomlins@cam.org> <3DF54BD7.726993D@digeo.com>
In-Reply-To: <3DF54BD7.726993D@digeo.com>
MIME-Version: 1.0
Content-Disposition: inline
Cc: Jens Axboe <axboe@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200302141638.44843.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
 
> The version posted the other day did fair queueing of requests between
> processes, but it did not help to provide fair request allocation. This
> version does that too, results are rather remarkable. In addition, the
> following changes were made:

The numbers from the second message are nice - especially considering this
is only the second iteration...

A question about io priorities.  I wonder if they could not be implemented
via a per pid cfq_quantum?  If I am not missunderstanding things, a bigger
value here for a given process should mean that it gets a larger share of 
the io bandwidth...

Comments?
Ed Tomlinson




