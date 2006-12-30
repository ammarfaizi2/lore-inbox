Return-Path: <linux-kernel-owner+w=401wt.eu-S1030296AbWL3Stz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbWL3Stz (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 13:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbWL3Stz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 13:49:55 -0500
Received: from p02c11o141.mxlogic.net ([208.65.145.64]:44362 "EHLO
	p02c11o141.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030293AbWL3Stx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 13:49:53 -0500
Date: Sat, 30 Dec 2006 20:49:59 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-sound@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
       PeiSen Hou <pshou@realtek.com.tw>
Subject: Re: No sound in KDE with intel hda since 2.6.20-rc1
Message-ID: <20061230184959.GC4225@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20061229062559.GB16659@mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061229062559.GB16659@mellanox.co.il>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 30 Dec 2006 18:51:56.0781 (UTC) FILETIME=[946AD9D0:01C72C43]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14904.000
X-TM-AS-Result: No--6.691200-4.000000-31
X-Spam: [F=0.0128078088; S=0.012(2006120601)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since 2.6.20-rc1 (tested both -rc1 and rc2), system notification sounds under
> KDE, and sound in games (e.g. TuxPaint) no longer seem to work on my T60
> thinkpad. Works fine under 2.6.19 though.  The strange thing is e.g. Amarok
> still plays music fine.

Update: Amarok was set to auto-detect the backend, KDE uses ALSA backend.
On 2.6.20-rc2, if I force Amarok to alsa backend, I get a message that
xine could not initialized any drivers and no sound. If I force it
to use oss interface Amarok works fine.

On 2.6.19 both alsa and oss work fine.

So it seems that something broken in the alsa API in my 2.6.20-rc2.


-- 
MST
