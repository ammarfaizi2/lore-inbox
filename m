Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284144AbSCCNTx>; Sun, 3 Mar 2002 08:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285060AbSCCNTe>; Sun, 3 Mar 2002 08:19:34 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:29448 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S284144AbSCCNT1>; Sun, 3 Mar 2002 08:19:27 -0500
Date: Sun, 3 Mar 2002 14:19:24 +0100
From: Jan Kara <jack@suse.cz>
To: Craig Christophel <merlin@transgeek.com>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: Re: Quota patches for 2.5
Message-ID: <20020303131924.GG29815@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020303092308Z293039-31668+14@thor.valueweb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020303092308Z293039-31668+14@thor.valueweb.net>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Included in the following 13 emails are Jan Kara's current quota patches 
> forward ported to 2.5.6-pre2. They comprise a rewrite of the quota system 
> allowing for quota plugins much like filesystem plugins and a new quota 
> structure.  He will have to comment on the stability, but they look good from 
> where I sit.
> 
> 	He origionally has 12 patches which are included, and I added one patch to 
> change sync_dquot_dev to sync_dquot_all and fix all of the references to 
> dquot->dq_dev as Al Viro is getting rid of kdev_t in the places where this 
> was to be used.  Also fixed are some compile errors created by me misspelling 
> on the cut/paste portion.  
  Thanks Craig for your porting. I'll include your changes in last patch into
appropriate places in my patches, do some minor #ifdef changes in backward
compatible interface and put the patches (probably against 2.5.5) on ftp...
If there won't be objections I'll submit patches to Linus next week so you can
work on standard kernel...

									Honza
--
Jan Kara <jack@suse.cz>
SuSE CR Labs
