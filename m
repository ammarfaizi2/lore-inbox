Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261905AbSI3D2R>; Sun, 29 Sep 2002 23:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261906AbSI3D2R>; Sun, 29 Sep 2002 23:28:17 -0400
Received: from dp.samba.org ([66.70.73.150]:5259 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261905AbSI3D2R>;
	Sun, 29 Sep 2002 23:28:17 -0400
Date: Mon, 30 Sep 2002 13:33:44 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: newsgate@linuxguru.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Orinoco 2.5.39 include fix
Message-ID: <20020930033344.GE10265@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	newsgate@linuxguru.net, linux-kernel@vger.kernel.org
References: <20020929201159.GA4933@comet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020929201159.GA4933@comet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 04:11:59PM -0400, newsgate@linuxguru.net wrote:
> 2.5.39 with orinoco support fails to include because of tqueue.h isn't
> included. This patch fixes that so that the orinoco module compiles.  
> 
> This patch has been untested because the keyboard on my Toshiba 505-S5004
> has not worked since 2.5.31. :(
> 
> 
> (An aside -- Some day I'm going to have a kernel patch accepted. Some
> day...)

Hmm.. I can't seem to reproduce the problem (but I'm having trouble
getting 2.5.39 to compile at all on my PowerMac).  Nonetheless
tqueue.h should be included directly, so I've included a patch with
similar intent into the next driver update, patch coming soon.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
