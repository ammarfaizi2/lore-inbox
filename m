Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290958AbSBLTrc>; Tue, 12 Feb 2002 14:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290968AbSBLTrM>; Tue, 12 Feb 2002 14:47:12 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:46606 "HELO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with SMTP
	id <S290958AbSBLTrJ>; Tue, 12 Feb 2002 14:47:09 -0500
Date: Tue, 12 Feb 2002 20:47:10 +0100
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Cc: Matt Gauthier <elleron@yahoo.com>
Subject: Re: secure erasure of files?
Message-ID: <20020212204710.A7416@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org,
	Matt Gauthier <elleron@yahoo.com>
In-Reply-To: <Pine.LNX.4.30.0202121409150.18597-100000@mustard.heime.net> <Pine.LNX.4.33.0202121438560.7616-100000@unicef.org.yu> <20020212165504.A5915@devcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020212165504.A5915@devcon.net>; from aferber@techfak.uni-bielefeld.de on Tue, Feb 12, 2002 at 04:55:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't know if any filesystem currently relocates blocks if you
> overwrite a file, but it's certainly possible and allowed (everything
> else except the filesystem itself simply must not care where the data
> actually ends up on the disk).

AFAIK, ext2 tries to defragment files when possible. Thus if the file was
fragmented and the blocks after some fragment are free, it will use these
instead of the original ones somewhere far apart.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
