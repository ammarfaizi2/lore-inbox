Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbVF2Jvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbVF2Jvj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 05:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVF2Jvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 05:51:39 -0400
Received: from free.hands.com ([83.142.228.128]:22950 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S262318AbVF2Jvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 05:51:32 -0400
Date: Wed, 29 Jun 2005 11:00:26 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: Grzegorz Kulewski <kangur@polcom.net>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com
Subject: Re: accessing loopback filesystem+partitions on a file
Message-ID: <20050629100026.GG10219@lkcl.net>
References: <20050628233335.GB9087@lkcl.net> <Pine.LNX.4.63.0506290228380.7125@alpha.polcom.net> <20050629013731.GF9566@lkcl.net> <17089.65016.112262.278719@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17089.65016.112262.278719@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 11:48:40AM +1000, Peter Chubb wrote:

> Luke> that loopback filesystems cannot be presented as block devices
> Luke> by the linux kernel (with no involvement of xen) seems to be a
> Luke> curious omission.
> 
> But they can!  But a loopback device can't be partitioned.  So do it
> one partition at a time.

 ian and mark kindly responded pointing out some programs which
 make that possible.

 i liked the LVM one best.

> You'll probably only have a few real filesystems on the disk image
> anyway.
 
 hi peter, thank you for responding.

 see http://hands.com/d-i, searching for "xen0".

 the key is to be able to test-run debian installations in
 a xen guest domain (with absolute minimal changes to the
 packages or the debian boot installs).

 and of course a debian install expects to see a hard drive, which it
 expects to be able to partition - so it is given one.

 l.

