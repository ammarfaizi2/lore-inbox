Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbTIYVvr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 17:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbTIYVup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 17:50:45 -0400
Received: from mail.kroah.org ([65.200.24.183]:27292 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261907AbTIYVuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 17:50:24 -0400
Date: Thu, 25 Sep 2003 14:14:34 -0700
From: Greg KH <greg@kroah.com>
To: Martin Kacer <M.Kacer@sh.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with USB/VISOR module
Message-ID: <20030925211434.GC29680@kroah.com>
References: <Pine.LNX.4.58.0309251218460.24867@duck.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0309251218460.24867@duck.sh.cvut.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 12:34:30PM +0200, Martin Kacer wrote:
> Hello folks:
> 
> I got problems using the visor module and hotsyncing my PDA with Linux.
> 
> My configuration is probably correct, since everything worked just fine
> until I bought a new motherboard - D865GBF by Intel (Intel Bayfield).
> With the new board, I am not able to connect to the PDA.
> 
> PDA: Palm m515, USB craddle
> PC: D865GBF board, Intel Celeron, 2GHz, 400MHz System Bus
> Kernel: 2.4.22 and 2.4.21 tried (it worked with 2.4.21 formerly)
> Software: pilot-link version 0.9.5.0-8 (Debian "testing" package)
> (used to work with my previous CPU and board - some Intel based on i845)
> 
> Problem decription: the PDA is detected after pressing the HotSync button,
> but the syncing process hangs just after opening the port. Nothing is read
> or written.

Why are you trying to attach to port 0?  What happens with:
	pilot-xfer -p /dev/ttyUSB1 -l

thanks,

greg k-h
