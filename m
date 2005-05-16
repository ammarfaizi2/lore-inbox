Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVEPPa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVEPPa2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 11:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVEPP2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 11:28:23 -0400
Received: from mail.dif.dk ([193.138.115.101]:63426 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261703AbVEPP13 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 11:27:29 -0400
Date: Mon, 16 May 2005 17:31:23 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: =?iso-8859-1?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ? (on amd64 ?)
In-Reply-To: <20050516151201.GD9558@gmail.com>
Message-ID: <Pine.LNX.4.62.0505161728010.2390@dragon.hyggekrogen.localhost>
References: <20050516085832.GA9558@gmail.com>
 <Pine.LNX.4.62.0505161701410.2390@dragon.hyggekrogen.localhost>
 <20050516151201.GD9558@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005, Grégoire Favre wrote:

> On Mon, May 16, 2005 at 05:03:56PM +0200, Jesper Juhl wrote:
> 
> > Not me, it works perfectly here, but then I have different hardware (but 
> > using the aic7xxx driver).
> 
> You are lucky, maybe I should also mention that I am under x86_64 ?
> 

Have you tried enabling some of the debug options and the options that 
give you more verbose errors?  That might help diagnose what wrong. Just a 
guess, I don't know, but I'd try these options : 

CONFIG_SCSI_CONSTANTS
CONFIG_SCSI_LOGGING
CONFIG_AIC7XXX_DEBUG_ENABLE
CONFIG_AIC7XXX_DEBUG_MASK
CONFIG_AIC7XXX_REG_PRETTY_PRINT

read the help for those options to see what they do and how to use them.


-- 
Jesper Juhl


