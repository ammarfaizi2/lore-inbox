Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264616AbTCZDbh>; Tue, 25 Mar 2003 22:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264608AbTCZDbg>; Tue, 25 Mar 2003 22:31:36 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:60046 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S264614AbTCZDba>;
	Tue, 25 Mar 2003 22:31:30 -0500
Date: Tue, 25 Mar 2003 22:45:14 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Jaroslav Kysela <perex@suse.cz>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5] PnP changes to allow MODULE_DEVICE_TABLE()
Message-ID: <20030325224514.GF607@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Daniel Ritz <daniel.ritz@gmx.ch>, Jaroslav Kysela <perex@suse.cz>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200303242354.03527.daniel.ritz@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303242354.03527.daniel.ritz@gmx.ch>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 11:54:02PM +0100, Daniel Ritz wrote:
> hello adam, jaroslav, list
> 
> this patch does:
> - rename struct pnp_card_id to pnp_card_device_id
> - fix all references to it
> 
> this is needed for the MODULE_DEVICE_TABLE() macro to work with pnp_card's.
> jaroslav did this a while ago (changeset 1.879.79.1), but adam undid it a bit
> later (changeset 1.889.202.3). but why?
> 
> w/o the patch gcc dies when compiling als100.c with the message 'storage size
> of __mod_pnp_card_device_table unknown' (this is from the macro).
> 
> any reasons why i should not send this to linus?
> against 2.5.65-bk
> 
> rgds
> -daniel
> 

That change was accidentally lost during a merge.  Thanks for this patch, it 
looks good and I added it to my changes for 2.5.66.

Regards,
Adam
