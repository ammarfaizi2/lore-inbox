Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbTEHQxo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 12:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbTEHQxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 12:53:44 -0400
Received: from 101.24.177.216.inaddr.G4.NET ([216.177.24.101]:38074 "EHLO
	sparrow.stearns.org") by vger.kernel.org with ESMTP id S261861AbTEHQxn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 12:53:43 -0400
Date: Thu, 8 May 2003 13:02:21 -0400 (EDT)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow-zaphod
Reply-To: William Stearns <wstearns@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jesse Pollard <jesse@cats-chateau.net>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Terje Eggestad <terje.eggestad@scali.com>,
       Erez Zadok <ezk@shekel.mcl.cs.columbia.edu>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <1052407341.10038.69.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0305081258320.9839-100000@sparrow-zaphod>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, all,

On 8 May 2003, Alan Cox wrote:

> > There is NO reason a custom filesystem cannot be layered over other 
> > filesystems. It might not be done today (though the references to "userfs"
> > keep showing up in such discussions).
> 
> Erez Zadoz (not sure of the spelling) did some stacking fs modules on
> Linux

	Erez Zadok maintains the FiST (File System Translator) project at 
http://www1.cs.columbia.edu/~ezk/research/fist/ .  For those not familiar 
with the project, one writes an upper level filesystem that can modify VFS 
requests or results, providing a VFS proxy.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"All programs evolve until they can send email."
-- Richard Letts
	"Except Microsoft Exchange."
-- Art
	(found on the Snort web site)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
Linux articles at:                         http://www.opensourcedigest.com
--------------------------------------------------------------------------

