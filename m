Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264986AbTANTOG>; Tue, 14 Jan 2003 14:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265012AbTANTOG>; Tue, 14 Jan 2003 14:14:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:7396 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264986AbTANTOF>;
	Tue, 14 Jan 2003 14:14:05 -0500
Date: Tue, 14 Jan 2003 20:22:40 +0100
From: Jens Axboe <axboe@suse.de>
To: Christian Boon <cboon@kabelfoon.nl>, linux-kernel@vger.kernel.org
Subject: Re: I/O error
Message-ID: <20030114192240.GG21062@suse.de>
References: <1042572315.987.10.camel@client1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042572315.987.10.camel@client1>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14 2003, Christian Boon wrote:
> i continuously get the following messages in my dmesg, kernel 2.5.58 :
> 
> end_request: I/O error, dev hda, sector 0
> end_request: I/O error, dev hda, sector 0
> end_request: I/O error, dev hda, sector 0
> end_request: I/O error, dev hda, sector 0

You probably have something opening/closing your cdrom drive regularly.
It's a known issue, don't worry about it. If your cdrom appears to work,
then it's purely cosmetic.

-- 
Jens Axboe

