Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261895AbTCGX2S>; Fri, 7 Mar 2003 18:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261892AbTCGX2R>; Fri, 7 Mar 2003 18:28:17 -0500
Received: from thunk.org ([140.239.227.29]:6833 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261875AbTCGX2Q>;
	Fri, 7 Mar 2003 18:28:16 -0500
Date: Fri, 7 Mar 2003 18:38:39 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Bryan Whitehead <driver@jpl.nasa.gov>
Cc: linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org
Subject: Re: devfs + PCI serial card = no extra serial ports
Message-ID: <20030307233839.GB24572@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Bryan Whitehead <driver@jpl.nasa.gov>, linux-kernel@vger.kernel.org,
	linux-newbie@vger.kernel.org
References: <3E692281.10906@jpl.nasa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E692281.10906@jpl.nasa.gov>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 02:51:45PM -0800, Bryan Whitehead wrote:
> It seems devfsd has an annoying "feature". I bought a PCI card to get a 
> couple (2) more serial ports. The kernel doesn't seem to set up the 
> serial ports at boot, so devfs never creates an entry. However, post 
> boot, since there is no entries, I cannot configure the serial ports 
> with setserial. So basically devfsd = no PCI based serial add on?

Yep.  This I pointed this out as a flaw to devfs a long, long time
(years!) ago, but Richard chose not to listen to me.  Personally, I
solve this (and other) problems by simply refusing to use devfs.

						- Ted
