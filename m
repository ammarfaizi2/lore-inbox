Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbSLJRBw>; Tue, 10 Dec 2002 12:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSLJRBw>; Tue, 10 Dec 2002 12:01:52 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:58068 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263204AbSLJRBv>; Tue, 10 Dec 2002 12:01:51 -0500
Date: Tue, 10 Dec 2002 17:09:39 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: ebuddington@wesleyan.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.51 won't boot with devfs enabled
Message-ID: <20021210170939.GC577@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	ebuddington@wesleyan.edu, linux-kernel@vger.kernel.org
References: <20021210111835.A92@ma-northadams1b-112.bur.adelphia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021210111835.A92@ma-northadams1b-112.bur.adelphia.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 11:18:35AM -0500, Eric Buddington wrote:
 > With 2.5.51 (gcc-3.2, Athlon, mostly modules, DEVFS=y, DEVFS_DEBUG=y),
 > boot panics with "VFS: Cannot open root device "hda1" or
 > 03:01".
 > 
 > I had the same problem with 2.5.50, avoidable by disabling devfs entirely.

Sounds similar to http://bugzilla.kernel.org/show_bug.cgi?id=110
Does enabling UNIX98 pty's fix your problem ?

        Dave

