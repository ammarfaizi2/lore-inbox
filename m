Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262923AbRFWOHS>; Sat, 23 Jun 2001 10:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263020AbRFWOHI>; Sat, 23 Jun 2001 10:07:08 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:1037 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262923AbRFWOG7>; Sat, 23 Jun 2001 10:06:59 -0400
Date: Sat, 23 Jun 2001 16:06:58 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: RPC vs Socket
Message-ID: <20010623160658.A19533@artax.karlin.mff.cuni.cz>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010621052321.24581.qmail@nw171.netaddress.usa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010621052321.24581.qmail@nw171.netaddress.usa.net>; from blessonpaul@usa.net on Wed, Jun 20, 2001 at 11:23:21PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>                       I am in the way of building  a new remote file system.
> Presently I decided to use sockets for remote communication. Lately I
> understood that RPC is used in coda and nfs file systems(is it so).  I want to
> know the fessibility in using RPC in the new file system.

Both seem to have pros and cons. RPC should be easier to write (especialy the
server side), but it performs bad with UDP on slow links. (NFS did not work on
115200 serial line because of too many dropped packets - TCP flow control too
badly needed in such cases). Or can linux do RPC over TCP?

For puropose of shool excercise the work saved with RPC might be tha main argument.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
