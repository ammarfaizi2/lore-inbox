Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWFWCyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWFWCyf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 22:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbWFWCyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 22:54:35 -0400
Received: from [198.99.130.12] ([198.99.130.12]:30346 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750968AbWFWCye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 22:54:34 -0400
Date: Thu, 22 Jun 2006 22:54:18 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Theodore Tso <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1: UML failing w/o SKAS enabled
Message-ID: <20060623025418.GC8316@ccure.user-mode-linux.org>
References: <20060621034857.35cfe36f.akpm@osdl.org> <20060622213443.GA22303@thunk.org> <20060622145743.2accfeaf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622145743.2accfeaf.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 02:57:43PM -0700, Andrew Morton wrote:
> I haven't run UML in several years, alas.  I should work out how to do it
> (again).   Links to any uml-for-dummies site would be appreciated ;)

http://user-mode-linux.sourceforge.net/new/index.html

Scroll down to the "Getting Started" section.  You download two files,
uncompress them, and run UML.  The only way I can think to make it
easier would be to make it one file by sticking the filesystem in an
initramfs :-)

For building UML, see
	http://user-mode-linux.sourceforge.net/new/source.html

The important thing is to start with a defconfig in order to avoid
config grabbing the host's config from /boot.

				Jeff
