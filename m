Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270329AbTGUXXb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 19:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270756AbTGUXXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 19:23:31 -0400
Received: from guug.org ([168.234.203.30]:52692 "EHLO guug.galileo.edu")
	by vger.kernel.org with ESMTP id S270329AbTGUXXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 19:23:30 -0400
Date: Mon, 21 Jul 2003 17:34:04 -0600
To: Viaris <bmeneses_beltran@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.5.75 OK but tape backup not work
Message-ID: <20030721233404.GA25561@guug.org>
References: <Law11-OE66yNP29M5f8000100c8@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Law11-OE66yNP29M5f8000100c8@hotmail.com>
User-Agent: Mutt/1.5.4i
From: Otto Solares <solca@guug.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 04:39:16PM -0600, Viaris wrote:
> Hi
> 
> My problem was resuelt (I installed  module inits again), now I can see all
> modules loaded, but I have problems, when I want to see my backup, I can't ,
> I execute tar tvf /dev/st0 and the follwing message appear:
> 
> tar: /dev/st0: Cannot open: No such device
> tar: Error is not recoverable: exiting now
> 
> I believe that my server not know this device, but I  execute lsmod the
> driver of my SCSI card is loaded:
> 
> scsi_mod              115892  2 dc395x,ide_scsi
> 
> I need to know that others test i can do it.

i think you must load the scsi tape driver:

modprobe st

-solca

