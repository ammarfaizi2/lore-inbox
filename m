Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129540AbRBXJid>; Sat, 24 Feb 2001 04:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129550AbRBXJiW>; Sat, 24 Feb 2001 04:38:22 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:23823 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129540AbRBXJiT>;
	Sat, 24 Feb 2001 04:38:19 -0500
Date: Sat, 24 Feb 2001 10:21:19 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jasmeet Sidhu <jsidhu@arraycomm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DMA blues...System lockup on setting DMA mode using hdparam
Message-ID: <20010224102119.A956@suse.cz>
In-Reply-To: <5.0.2.1.2.20010223120954.025fa3b0@pop.arraycomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.0.2.1.2.20010223120954.025fa3b0@pop.arraycomm.com>; from jsidhu@arraycomm.com on Fri, Feb 23, 2001 at 12:48:29PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2001 at 12:48:29PM -0800, Jasmeet Sidhu wrote:


> Also, when I try and use the -k and the -K switches (keep settings after 
> reset), the programs says that it worked.  However, after I restart the 
> system, these "flags" are set to 0 again.  Is this normal?  In other words:
> hdparam -k /dev/hda
>   keepsettings =  0 (off)
> # now lets set the -k option (keep settings after refresh).
> hdparam -k1 /dev/hda
>   setting keep_settings to 1 (on)
>   keepsettings =  1 (on)
> # noe lets restart the system and query again
> hdparam -k /dev/hda
>   keepsettings =  0 (off)
> 
> Is this normal?

This only relates to a ide bus reset in case of a failure, not system reset.

-- 
Vojtech Pavlik
SuSE Labs
