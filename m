Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264780AbTFLNHR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 09:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbTFLNHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 09:07:16 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:10382 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S264780AbTFLNHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 09:07:13 -0400
Date: Thu, 12 Jun 2003 15:20:58 +0200
From: bert hubert <ahu@ds9a.nl>
To: perex@suse.cz, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [updated] Re: snd_pcm_oss: Oopsen with resampling
Message-ID: <20030612132058.GA18938@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, perex@suse.cz,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20030612124528.GA18274@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612124528.GA18274@outpost.ds9a.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 02:45:28PM +0200, bert hubert wrote:

> Anyhow, when playing at 22050 Hz, I get the oops below after about 200ms of
> sound, at 44010 there is no problem. It doesn't always occur though.

This is wrong. What actually causes the oops is playing two sounds
simultaneously. It doesn't happen if I send two identical mono .wav sounds
at the same time, but it does when xmms is playing a stereo mp3 and I send a
mono .wav sound.

Playing a stereo .wav and two mono wav's does not trigger this.

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
