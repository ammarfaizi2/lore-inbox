Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbTDXE3L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 00:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264393AbTDXE3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 00:29:11 -0400
Received: from granite.he.net ([216.218.226.66]:19218 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264392AbTDXE3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 00:29:10 -0400
Date: Wed, 23 Apr 2003 21:43:28 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
Message-ID: <20030424044328.GA15360@kroah.com>
References: <Pine.LNX.4.44.0304232012400.19176-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304232012400.19176-100000@home.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 08:59:45PM -0700, Linus Torvalds wrote:
> 
> Btw, one thing that is clearly _not_ allowed by the GPL is hiding private
> keys in the binary. You can sign the binary that is a result of the build
> process, but you can _not_ make a binary that is aware of certain keys
> without making those keys public - because those keys will obviously have
> been part of the kernel build itself.

The GPL does allow you to embed a public key in the kernel, which could
enforce only executables signed with a private key from being run, or
only signed modules from being loaded.  Both of which are things that I
know a lot of people want to do (and I've done in the past, see
http://linuxusb.bkbits.net:8080/cryptomark-2.4 for the 2.4 version of a
signed binaries are only allowed to run patch.)

I know a lot of people can (and do) object to such a potential use of
Linux, and I'm glad to see you explicitly state that this is an
acceptable use, it helps to clear up the issue.

thanks,

greg k-h
