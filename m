Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752629AbWLCPua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbWLCPua (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 10:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752809AbWLCPua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 10:50:30 -0500
Received: from kallisti.us ([67.59.168.233]:54538 "EHLO kallisti.us")
	by vger.kernel.org with ESMTP id S1752629AbWLCPu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 10:50:29 -0500
From: Ross Vandegrift <ross@kallisti.us>
Date: Sun, 3 Dec 2006 10:49:36 -0500
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: why can't I remove a kernel module (or: what uses a given module)?
Message-ID: <20061203154936.GB26669@kallisti.us>
References: <4572B30F.9020605@wpkg.org> <jewt592oxf.fsf@sykes.suse.de> <4572BBE0.4010801@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4572BBE0.4010801@wpkg.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2006 at 12:58:24PM +0100, Tomasz Chmielewski wrote:
> You mean the "Used by" column? No, it's not used by any other module 
> according to lsmod output.
> 
> Any other methods of checking what uses /dev/sda*?

There's a good chance that if it was loaded at system boot, hald or
udev may be doing something with it.

When you loaded it manually, you didn't have udev rescan for devices
so they didn't notice that you had loaded up a new disk.

-- 
Ross Vandegrift
ross@kallisti.us

"The good Christian should beware of mathematicians, and all those who
make empty prophecies. The danger already exists that the mathematicians
have made a covenant with the devil to darken the spirit and to confine
man in the bonds of Hell."
	--St. Augustine, De Genesi ad Litteram, Book II, xviii, 37
