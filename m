Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756168AbWKVR7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168AbWKVR7H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 12:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756171AbWKVR7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 12:59:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48074 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1756168AbWKVR7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 12:59:04 -0500
Date: Wed, 22 Nov 2006 12:58:56 -0500
From: Dave Jones <davej@redhat.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Simple script that locks up my box with recent kernels
Message-ID: <20061122175856.GH533@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	=?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Jesper Juhl <jesper.juhl@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <9a8748490610161545i309c416aja4f39edef8ea04e2@mail.gmail.com> <Pine.LNX.4.64.0610161554140.3962@g5.osdl.org> <9a8748490610161613y7c314e64rfdfafb4046a33a02@mail.gmail.com> <9a8748490610231330y65f3e243pe1101d11a28dbbfa@mail.gmail.com> <9a8748490611211646o2c92564dmfe8d6ffdf66228ba@mail.gmail.com> <Pine.LNX.4.64.0611211827590.3338@woody.osdl.org> <20061122032512.GE533@redhat.com> <Pine.LNX.4.64.0611211944120.3352@woody.osdl.org> <20061122034928.GF533@redhat.com> <45642744.2080109@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45642744.2080109@draigBrady.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 10:32:36AM +0000, Pádraig Brady wrote:

 > > Heh, it's amazing how commonplace that mistake is.
 > > Come back bzero, all is forgiven..
 > 
 > It's interesting to do the following on google codesearch
 > 
 > lang:^(c|c\+\+)$ memset\ *\(.*,\ *0\ *\);
 > http://tinyurl.com/y47qu4
 > 
 > lang:^(c|c\+\+)$ \sif\([^)]*\);
 > http://tinyurl.com/y4mdbl
 > 
 > It would be interesting to build
 > up a suite of these regular expressions.

A bunch of people already started gathering these a day
or so after codesearch launched..

http://asert.arbornetworks.com/2006/10/static-code-analysis-using-google-code-search/
is a good start.
http://www.cipher.org.uk/index.php?p=projects/bugle.project
is also somewhat interesting (but from a security bug standpoint only)

I've got some crufty shell scripts that I grew that I use
from time to time that just grep a bunch of patterns, I've had
"put them all together and make one decent one" on my todo
for a while. I'll see if I can get to it this week.
I've used these occasionally not just to find bugs in the kernel
but across a completely unpacked distro source tree.
Amazing what turns up sometimes.

		Dave

-- 
http://www.codemonkey.org.uk
