Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292727AbSBUTPu>; Thu, 21 Feb 2002 14:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292728AbSBUTPk>; Thu, 21 Feb 2002 14:15:40 -0500
Received: from web10706.mail.yahoo.com ([216.136.130.214]:47884 "HELO
	web10706.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S292727AbSBUTP3>; Thu, 21 Feb 2002 14:15:29 -0500
Message-ID: <20020221191528.96395.qmail@web10706.mail.yahoo.com>
Date: Thu, 21 Feb 2002 11:15:28 -0800 (PST)
From: David Chase <lmdracos@yahoo.com>
Subject: General causes of oops'es?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm wondering what generally can cause an oops.  I've
been having a lot lately, and instead of bothering you
all with it, I'd rather try to narrow down the problem
myself.

In general, what can cause an oops?  Hardware failure?
 Memory problems?  Can erroneous data (ie from data
corruption on a drive, possibly corrupting a binary
that causes an oops?) be the cause of the oops?  My
boot drive's been unmounted a few times the past month
improperly, and had a few data integrity issues. 
Could that cause it?

Could a specific piece of running software cause an
oops involving another process?

Could it have anything to do with tune'ing an ext2 fs
to include ext3 journalling support (that is, should
the whole fs have been ext3 to begin with?  would this
cause problems?)?

The system is a Dual Celeron on an Abit BP6, 256MB
medium-grade RAM, Debian 2.2 (upgraded to unstable)
and kernel 2.4.17 compiled with ext3 support (and no
debugging support for ext3).

It seems to oops a lot with regards to kswapd.

Thanks in advance, and please cc: me any replies to this!

__________________________________________________
Do You Yahoo!?
Yahoo! Sports - Coverage of the 2002 Olympic Games
http://sports.yahoo.com
