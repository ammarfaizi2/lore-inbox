Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264433AbUAZTGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 14:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264455AbUAZTGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 14:06:17 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:61082 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S264433AbUAZTGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 14:06:13 -0500
Date: Mon, 26 Jan 2004 20:06:11 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.2-rc2] bttv oops
Message-ID: <20040126190611.GA23374@fubini.pci.uni-heidelberg.de>
References: <200401261829.31719.bernd-schubert@web.de> <87wu7evalw.fsf@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wu7evalw.fsf@bytesex.org>
User-Agent: Mutt/1.3.28i
From: Bernd Schubert <Bernd.Schubert@tc.pci.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 07:16:43PM +0100, Gerd Knorr wrote:
> Bernd Schubert <bernd-schubert@web.de> writes:
> 
> > Hello,
> > 
> > on loading the bttv driver I get the following messages:
> > 
> > EIP is at i2c_master_recv+0xc3/0x110 [i2c_core]
> 
> The debug printk's in i2c_core dereferences pointers without checking
> them first ...
> 
> Workaround:  Disable the i2c debug config options.
>

Ah thanks a lot, thats pretty simple and works fine.


Best regards,
	Bernd
