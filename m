Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264060AbTE0TdI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbTE0TdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:33:08 -0400
Received: from uldns1.unil.ch ([130.223.8.20]:44267 "EHLO uldns1.unil.ch")
	by vger.kernel.org with ESMTP id S264060AbTE0TdF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:33:05 -0400
Date: Tue, 27 May 2003 21:46:11 +0200
From: Gregoire Favre <greg@magma.unil.ch>
To: Nathan Scott <nathans@sgi.com>
Cc: Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: xfs don't compil in linux-2.5 BK
Message-ID: <20030527194611.GD17428@magma.unil.ch>
References: <20030526193136.GB10276@magma.unil.ch> <1053986469.3754.6.camel@nalesnik.localhost> <20030526223803.GB14954@magma.unil.ch> <20030526232144.GA705@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20030526232144.GA705@frodo>
User-Agent: Mutt/1.4.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 09:21:44AM +1000, Nathan Scott wrote:

> Are you missing "make oldconfig" or one of the other *config targets,
> perhaps?  Looks like some parts of your build haven't been done before
> you descend into fs/xfs - in particular, your <linux/version.h> header
> doesn't seem to have good stuff in it.

I have done a fresh bk checkout, and used (which I now know to be
outdated) (after having copied the .config from my 2.5.69).

make oldconfig && make menuconfig && make dep && make bzImage && make modules && sudo make modules_install

Certainly I did something totally wrong with bk :-(

Thank you,

	Grégoire
__________________________________________________________________
http://www-ima.unil.ch/greg ICQ:16624071 mailto:greg@magma.unil.ch
