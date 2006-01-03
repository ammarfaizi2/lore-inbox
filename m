Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWACLsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWACLsT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 06:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWACLsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 06:48:19 -0500
Received: from ns2.suse.de ([195.135.220.15]:47563 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751381AbWACLsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 06:48:18 -0500
Date: Tue, 3 Jan 2006 12:48:16 +0100
From: Karsten Keil <kkeil@suse.de>
To: Jan Blunck <jblunck@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       isdn4linux@listserv.isdn4linux.de
Subject: Re: [PATCH 3/3] __attribute__((packed)) for the CAPI message structs
Message-ID: <20060103114816.GC8751@pingi3.kke.suse.de>
Mail-Followup-To: Jan Blunck <jblunck@suse.de>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, isdn4linux@listserv.isdn4linux.de
References: <20060103113136.GD24131@hasse.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060103113136.GD24131@hasse.suse.de>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.13-15-default i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 12:31:36PM +0100, Jan Blunck wrote:
> The CAPI message structs itself should be packed and not the location of
> single fields in the structure.
> 
> Signed-off-by: Jan Blunck <jblunck@suse.de>

Yes this should be changed.

Signed-off-by: Karsten Keil <kkeil@suse.de>

>  drivers/isdn/act2000/capi.h |   88 ++++++++++++++++++++++----------------------
>  1 files changed, 44 insertions(+), 44 deletions(-)
> 
> Index: linux-2.6/drivers/isdn/act2000/capi.h
> ===================================================================
...


-- 
Karsten Keil
SuSE Labs
ISDN development
