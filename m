Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbTKHRI5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 12:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTKHRI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 12:08:56 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:59915 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261850AbTKHRIz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 12:08:55 -0500
Date: Sat, 8 Nov 2003 18:18:58 +0100
To: Rob Landley <rob@landley.net>
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>, linux-kernel@vger.kernel.org
Subject: Re: 2.6: value 0x37ffffff truncated to 0x37ffffff
Message-ID: <20031108171858.GA6489@hh.idb.hist.no>
References: <Pine.LNX.4.51.0311071628470.5963@dns.toxicfilms.tv> <200311080142.45003.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311080142.45003.rob@landley.net>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 08, 2003 at 01:42:44AM -0600, Rob Landley wrote:
> On Friday 07 November 2003 09:36, Maciej Soltysiak wrote:

> > arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to
> > 0x37ffffff LD      arch/i386/boot/setup
> 
> What version of the tools you're using to compile it, maybe?  (Distro, gcc 
> version, binutils version, etc...  And if it's a non-intel system or 
> cross-compiling or something, that might be good to mention too...)
> 
I have seen this for along time with debian testing, on intel.
I use gcc 3.3.2,
binutils: 2.14.90.0.6-5
I had the impressien that it doesn't matter, because it is
truncated to the same value.  I.e. no change, only a strange message?


Helge Hafting
