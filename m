Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283291AbRLDTGO>; Tue, 4 Dec 2001 14:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283293AbRLDTEt>; Tue, 4 Dec 2001 14:04:49 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:64261 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283273AbRLDTDy>;
	Tue, 4 Dec 2001 14:03:54 -0500
Date: Tue, 4 Dec 2001 20:03:31 +0100
From: Jens Axboe <axboe@suse.de>
To: Stephen Cameron <smcameron@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cciss max SGs is 31, not 32, 2.5.1-pre5
Message-ID: <20011204200331.F15152@suse.de>
In-Reply-To: <20011204170252.43996.qmail@web12302.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011204170252.43996.qmail@web12302.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04 2001, Stephen Cameron wrote:
> Guys,
> 
> wrt 2.5.1-pre5
> 
> The change below should be reverted.  The controller will reject a command
> with 32 scatter gather entries.  

Oops, probably my mistake. Funny thing is even tested this months ago
and came to the same conclusion (your docs are not that good...), I
guess it survived in the 2.5 tree because of lack of testing.

-- 
Jens Axboe

