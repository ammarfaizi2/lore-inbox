Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291179AbSBLVPC>; Tue, 12 Feb 2002 16:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291191AbSBLVOw>; Tue, 12 Feb 2002 16:14:52 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:39692 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S291179AbSBLVOf>;
	Tue, 12 Feb 2002 16:14:35 -0500
Date: Tue, 12 Feb 2002 11:00:49 +0100
From: Pavel Machek <pavel@suse.cz>
To: Bill Davidsen <davidsen@tmr.com>
Cc: davej@suse.de, kernel list <linux-kernel@vger.kernel.org>, vojtech@ucw.cz
Subject: Re: ide cleanup
Message-ID: <20020212100048.GC1029@elf.ucw.cz>
In-Reply-To: <20020209193500.A18944@suse.cz> <Pine.LNX.3.96.1020211140942.642C-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020211140942.642C-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Just my opinion, code should be written to be EASILY read rather than as
> if to be entered in an obfuscated C contest. This is not that bad, but the

#ifdef is *the* tool to make obfuscated code. It does not fit there,
and makes it hard to parse. #ifdefs are to be avoided.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
