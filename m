Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275970AbRJBJ3Q>; Tue, 2 Oct 2001 05:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275971AbRJBJ3H>; Tue, 2 Oct 2001 05:29:07 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:3089 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S275970AbRJBJ24>;
	Tue, 2 Oct 2001 05:28:56 -0400
Date: Tue, 2 Oct 2001 11:29:21 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
        Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: Ethernet Error Correction
Message-ID: <20011002112921.A7117@suse.cz>
In-Reply-To: <20010925223437.A21831@atrey.karlin.mff.cuni.cz> <20010926004345.D11046@mea-ext.zmailer.org> <20010927142251.A58@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010927142251.A58@toy.ucw.cz>; from pavel@suse.cz on Thu, Sep 27, 2001 at 02:22:51PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2001 at 02:22:51PM +0000, Pavel Machek wrote:
> Hi!
> 
> > 	Also, generic PROMISC mode still drops off received frames
> > 	with CRC error.
> 
> Hmm, sounds good. Someone should create tool for communication over
> ethernet with broken crc's. Such communication would be stealth from
> normal tcpdump. Do it on your provider's network to escape accounting ;^)

But still you'll see the number of errors on your eth card
skyrocketing, so you'd grow quite suspicious. 

> 
> -- 
> Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
> details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
