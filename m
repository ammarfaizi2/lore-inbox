Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264660AbRFTW1H>; Wed, 20 Jun 2001 18:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263469AbRFTW05>; Wed, 20 Jun 2001 18:26:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30726 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S264656AbRFTW0m>; Wed, 20 Jun 2001 18:26:42 -0400
Date: Thu, 21 Jun 2001 00:26:18 +0200
From: Jan Kara <jack@suse.cz>
To: "SATHISH.J" <sathish.j@tatainfotech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: filldir() function
Message-ID: <20010621002618.A6753@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.10.10106181324110.11158-100000@blrmail> <Pine.LNX.4.10.10106201509560.27257-100000@blrmail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.10.10106201509560.27257-100000@blrmail>; from sathish.j@tatainfotech.com on Wed, Jun 20, 2001 at 03:11:56PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> Please someone tell me what is the function of filldir() function. I
> could not understand it from the code. Just give me an outline of what it
> will do.
  This function is used in foo_readdir() (ie. ext2_readdir()). Purpose
of this function is to copy given data to buffer supplied by user.

								Honza
--
Jan Kara <jack@suse.cz>
SuSE Labs
