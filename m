Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265603AbTCELML>; Wed, 5 Mar 2003 06:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265612AbTCELML>; Wed, 5 Mar 2003 06:12:11 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:36845 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S265603AbTCELMK>; Wed, 5 Mar 2003 06:12:10 -0500
Date: Wed, 5 Mar 2003 11:20:09 -0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Those ruddy punctuation fixes
Message-ID: <20030305122008.GA4280@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030305111015.B8883@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030305111015.B8883@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 11:10:15AM +0000, Russell King wrote:

 > Could we stop fix^wbreaking this stuff please.  GCC 3.2.2:
 > ...
 > include/asm/proc-fns.h:128:39: missing terminating ' character

100% agreed. People really are going too far IMO.
Given that most people will never read those comments, the
effort would be much better spent proof-reading/correcting
documentation than comments.

The "its just a spelling mistake, it cant break the build!"
mantra is also way off base. If you touch a .c/.h file, you
introduce the possibility of breakage.

The cant -> can't pedantry is an example of just how extremely
silly these are getting. Is there really someone who sees
"cant" and doesn't understand what it could mean?
It just pedantic masturbation AFAICS.

		Dave

