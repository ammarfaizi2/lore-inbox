Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWAKVVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWAKVVi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWAKVVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:21:38 -0500
Received: from isilmar.linta.de ([213.239.214.66]:61663 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1750733AbWAKVVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:21:37 -0500
Date: Wed, 11 Jan 2006 22:21:35 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-mm3
Message-ID: <20060111212135.GA32021@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Brice Goglin <Brice.Goglin@ens-lyon.org>,
	Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <20060111042135.24faf878.akpm@osdl.org> <43C54FB9.9080906@ens-lyon.org> <20060111184012.GA19604@isilmar.linta.de> <43C55761.1090106@ens-lyon.org> <20060111195553.GA15739@isilmar.linta.de> <43C56A6C.8020707@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C56A6C.8020707@ens-lyon.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 11, 2006 at 03:28:28PM -0500, Brice Goglin wrote:
> Dominik Brodowski wrote:
> 
> >Could you check whether this patch helps, please?
> >
> >  
> >
> No, sorry, it does not fix it.

Ouch.

> This patch is actually only white spaces cleanups and the addition of a
> spin_lock_irqrestore, right ?

Exactly. Could you pass the parameter pc_debug=9 to the "pcmcia" module,
please, and send me the resulting dmesg? I can't reproduce it here,
unfortunately...

Thanks!
	Dominik
