Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271631AbRHPUB0>; Thu, 16 Aug 2001 16:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271632AbRHPUBS>; Thu, 16 Aug 2001 16:01:18 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:49023 "EHLO
	arlab191.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S271631AbRHPUBG> convert rfc822-to-8bit; Thu, 16 Aug 2001 16:01:06 -0400
Subject: Re: limit cpu
From: Wes Felter <wmf@austin.ibm.com>
To: Eduardo =?ISO-8859-1?Q?Cort=E9s?= <the_beast@softhome.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010816012150Z268614-760+2237@vger.kernel.org>
In-Reply-To: <20010816012150Z268614-760+2237@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 16 Aug 2001 14:58:54 -0500
Message-Id: <997991934.20279.11.camel@arlab191.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Aug 2001 03:21:58 +0200, Eduardo Cortés wrote:
> hi,
> i want to know if linux can limit the max cpu usage (not cpu time) per user, 
> like freebsd login classes. I see /etc/security/limits.conf and ulimit from 
> bash, but they limit the max cpu time, not de max cpu usage (%cpu). 

There are a couple of patches:

http://www.cs.umass.edu/~lass/software/qlinux/
http://fairsched.sourceforge.net/
http://www.surriel.com/patches/2.3/2.3.99-3-schedpatch5

Wes Felter
System Software Department
IBM Austin Research Lab
11400 Burnet Rd., Austin, TX 78758
Tel 512-838-7933
