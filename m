Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbUDDJUH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 05:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbUDDJUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 05:20:07 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:16655 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S262285AbUDDJUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 05:20:02 -0400
To: James Morris <jmorris@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>,
       <selinux@tycho.nsa.gov>, <lksctp-developers@lists.sourceforge.net>
Subject: Re: [SELINUX] Add IPv6 support
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <Xine.LNX.4.44.0404040107120.7220-100000@thoron.boston.redhat.com> (James
 Morris's message of "Sun, 4 Apr 2004 01:33:09 -0500 (EST)")
References: <Xine.LNX.4.44.0404040107120.7220-100000@thoron.boston.redhat.com>
X-Hashcash: 0:040404:jmorris@redhat.com:0a28bb1d8e9611f4
X-Hashcash: 0:040404:sds@epoch.ncsc.mil:02271e4c4756e932
X-Hashcash: 0:040404:linux-kernel@vger.kernel.org:2aedc460e419f7ee
X-Hashcash: 0:040404:selinux@tycho.nsa.gov:413d2b3cc84e9ecf
X-Hashcash: 0:040404:lksctp-developers@lists.sourceforge.net:fbc7f5b0dfb419d3
Date: Sun, 04 Apr 2004 05:19:42 -0400
Message-ID: <m31xn42j81.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> JM == James Morris <jmorris@redhat.com> writes:

JM> send & receive TCP/UDP and raw IP packets

>From a scan through the patch, it looks like it does in fact only
handle those tcp, udp and raw.  

Sctp also should be supported by these mechanisms, given that 2.6
has both in the main tree.

I'd expect many systems which will be installed in the next few
quarters and which could make good use of the selinux controls 
will require sctp support.

-JimC

