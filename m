Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270973AbRH3VbI>; Thu, 30 Aug 2001 17:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270165AbRH3Va5>; Thu, 30 Aug 2001 17:30:57 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:2546
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S270973AbRH3Vam>; Thu, 30 Aug 2001 17:30:42 -0400
Date: Thu, 30 Aug 2001 14:30:55 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Reiserfs: how to mount without journal replay?
Message-ID: <20010830143055.B6933@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010826130858.A39@toy.ucw.cz> <15246.11218.125243.775849@gargle.gargle.HOWL> <20010830225323.A18630@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010830225323.A18630@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 10:53:23PM +0200, Pavel Machek wrote:
> 
> No stack trace, sorry. It refused to mount saying that attempting to
> write into log block.. That's panic. Reiserfsck is not usable in such
> case, because ... how do you run reiserfsck from partition you can't
> mount?
> 								Pavel

And how do you deal with that situation on xfs, ext3, or any other journaled
fs?  I don't think it even needs to be journaled at all.

If you have a broken ext2, and can't mount root, you're screwed until you
put it in another system to fix it...

Mike
