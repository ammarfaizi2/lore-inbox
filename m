Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbUKBVcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbUKBVcs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 16:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbUKBVcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 16:32:47 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:35495 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261900AbUKBVam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:30:42 -0500
Date: Tue, 2 Nov 2004 22:25:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SWsuspend in 2.6.9 - sound card does not work
Message-ID: <20041102212539.GC996@openzaurus.ucw.cz>
References: <20041027111830.GD4724@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027111830.GD4724@fi.muni.cz>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have an Asus M6R laptop (http://www.fi.muni.cz/~kas/m6r/) with ATI IXP
> integrated sound card. Under 2.6.8.1 I was able to use the sound card
> after software suspend (just had to restore mixer settings using alsactl).
> With 2.6.9 the sound card does not work after suspend/restore: No output no
> matter how I change mixer settings, and the playback is not timed properly
> (e.g. when mplayer tries to synchronize audio and video stream, the video
> goes too fast using all CPU time and no output to speakers/phones.
> 
> 	I will do a binary search over 2.6.9-pre patches, but I want to ask
> whether this problem looks familiar to anybody.
> 

Are there any changes in the sound module?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

