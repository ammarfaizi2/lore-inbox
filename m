Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbTJPJbR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 05:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbTJPJbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 05:31:17 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:23168 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S262784AbTJPJbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 05:31:16 -0400
Date: Thu, 16 Oct 2003 11:31:15 +0200
From: bert hubert <ahu@ds9a.nl>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PCM OSS] via82xx soundcard Oops
Message-ID: <20031016093115.GA27524@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Muli Ben-Yehuda <mulix@mulix.org>, linux-kernel@vger.kernel.org
References: <20031016083103.GA25472@outpost.ds9a.nl> <20031016084404.GR5017@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031016084404.GR5017@actcom.co.il>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 10:44:05AM +0200, Muli Ben-Yehuda wrote:
> On Thu, Oct 16, 2003 at 10:31:03AM +0200, bert hubert wrote:
> 
> > Via82xx soundcard, on running wavesurfer
> > (http://www.speech.kth.se/wavesurfer/download.html - excellent), I often get
> > an oops in snd_pcm_format_set_silence, especially with short segments of
> > sound:
> 
> Fixed in ALSA CVS and in Linus's bitkeeper tree. Will show up in
> -test8. 

I can confirm that test7-bk7 fixes this problem thanks Muli! 

The weird occasional speedup is still there, trying to figure out what that
might be.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
