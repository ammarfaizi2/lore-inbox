Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266298AbUANEnp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 23:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266305AbUANEno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 23:43:44 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:6303 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S266298AbUANEni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 23:43:38 -0500
Date: Tue, 13 Jan 2004 23:29:41 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Rene Herman <rene.herman@keyaccess.nl>,
       Santiago Garcia Mantinan <manty@manty.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: ALSA in 2.6 failing to find the OPL chip of the sb cards
Message-ID: <20040113232940.GC3188@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Takashi Iwai <tiwai@suse.de>,
	Rene Herman <rene.herman@keyaccess.nl>,
	Santiago Garcia Mantinan <manty@manty.net>,
	linux-kernel@vger.kernel.org
References: <20040107212916.GA978@man.manty.net> <s5hy8sixsor.wl@alsa2.suse.de> <20040109171715.GA933@man.manty.net> <s5hn08xgh06.wl@alsa2.suse.de> <20040109201423.GA1677@man.manty.net> <3FFFA8C3.6040609@keyaccess.nl> <4000E030.2020500@keyaccess.nl> <s5hr7y5b2oe.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hr7y5b2oe.wl@alsa2.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 04:35:13PM +0100, Takashi Iwai wrote:
> At Sun, 11 Jan 2004 06:33:36 +0100,
> Rene Herman wrote:
> >
> > [1  <text/plain; us-ascii (7bit)>]
> > Rene Herman wrote:
> >
> > NOTE: I seem unable to contact Adam Belay; his ISP is not accepting mail
> > from mine. Takashi, if you agree attached patch is a correct fix, could
> > you relay it to Adam?
>
> i forwarded it.

I agree with the overall strategy of the patch, but, during testing, I was able
to uncover a few bugs introduced by it.  I'm reworking how pnp handles flags
and should have an updated patch out soon.

Thanks,
Adam
