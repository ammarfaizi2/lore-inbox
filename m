Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbWEUTiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWEUTiH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 15:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbWEUTiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 15:38:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46721 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964929AbWEUTiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 15:38:05 -0400
Date: Sun, 21 May 2006 15:38:03 -0400
From: Dave Jones <davej@redhat.com>
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IDEA] Poor man's UPS
Message-ID: <20060521193803.GG8250@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>,
	linux-kernel@vger.kernel.org
References: <200605212131.47860.pgquiles@elpauer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605212131.47860.pgquiles@elpauer.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 09:31:30PM +0200, Pau Garcia i Quiles wrote:

 > A short description would be "continuous system hibernation". Say you are 
 > running Firefox, writing an e-mail in mutt and compiling the next X.org 
 > release. The power goes off, your computer crashes or something happens and 
 > you lose everything you were doing (yes, sadly you haved saved your e-mail as 
 > a draft yet).
 > 
 > The "continuous hibernation" is some kind of memory snapshots taken, say, 
 > every 5 minutes. The next time your system starts after a crash, it'd say "oh 
 > oh, looks like something went wrong" and offer you a list of the last N (for 
 > instance, 4) snapshots and you can recover your system to the very same state 
 > it was before power went off or your dog unplugged your CPU. It might even 
 > ask you which individual applications you want to start from that snapshot:  
 > maybe you don't want to start Quake 3.
 > 
 > Provided the implementation is fast enough and you have a large hard drive, it 
 > might even allow you to say: "I want to restore the system to the same stage 
 > it had on Monday, 11.04PM"
 > 
 > That's it. Please, shoot at the idea not at the idealist :-)

One problem is that the on-disk state may not match the state
of the running programs on resume, which could lead to all sorts
of bad things happening.

		Dave


-- 
http://www.codemonkey.org.uk
