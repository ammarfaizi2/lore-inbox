Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262748AbVBBS6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262748AbVBBS6O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 13:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVBBS4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 13:56:46 -0500
Received: from kenga.kmv.ru ([217.13.212.5]:19901 "EHLO kenga.kmv.ru")
	by vger.kernel.org with ESMTP id S262348AbVBBSy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 13:54:58 -0500
Date: Wed, 2 Feb 2005 21:53:39 +0300
From: "Andrey J. Melnikoff (TEMHOTA)" <temnota@kmv.ru>
To: Vasily Averin <vvs@sw.ru>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Atul Mukker <Atul.Mukker@lsil.com>,
       Sreenivas Bagalkote <Sreenivas.Bagalkote@lsil.com>
Subject: Re: [PATCH] Prevent NMI oopser
Message-ID: <20050202185338.GG19453@kmv.ru>
References: <41F5FC96.2010103@sw.ru> <20050131231752.GA17126@logos.cnet> <42011EFA.10109@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42011EFA.10109@sw.ru>
User-Agent: Mutt/1.5.6+20040907i
X-Data-Status: msg.XXeUZUDa:28661@kenga.kmv.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vasily Averin!

 On Wed, Feb 02, 2005 at 09:42:02PM +0300, Vasily Averin wrote next:

> Marcelo Tosatti wrote:
> >On Tue, Jan 25, 2005 at 11:00:22AM +0300, Vasily Averin wrote:
> >>You should unlock io_request_lock before msleep, like in latest versions
> >>of megaraid2 drivers.
> >
> >Andrey, 
> >
> >Can you please update your patch to unlock io_request_lock before sleeping
> >and locking after coming back? 
> >
> >What the driver is doing is indeed wrong.
> 
> Marcelo,
> 
> This is megaraid2 driver update (2.10.8.2 version, latest 2.4-compatible
> version that I've seen), 
Where ? Last version (i see announce + patch from 2.10.3) is 2.10.6. 

> taken from latest RHEL3 kernel update. I believe it should prevent NMI 
> in abort/reset handler.
Thnx for patch, I try it on my server at next week.

-- 
 Best regards, TEMHOTA-RIPN aka MJA13-RIPE
 System Administrator. mailto:temnota@kmv.ru

