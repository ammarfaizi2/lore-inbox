Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266245AbUIJAeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266245AbUIJAeH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 20:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266574AbUIJAeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 20:34:07 -0400
Received: from open.hands.com ([195.224.53.39]:42463 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S266245AbUIJAeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 20:34:01 -0400
Date: Fri, 10 Sep 2004 01:45:17 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Cc: coreteam@netfilter.org
Subject: why is sk->skb->sk_socket->file  NULL on incoming packets?
Message-ID: <20040910004517.GC7587@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, simple question - if a userspace ip_queue program (fireflier)
can determine the pid of an incoming packet, why can't ipt_owner.c
do the same?

how do i force, even by using a userspace thing which asks the
packet to be "re-examined", the skb->sk->sk_socket->file to be
set?

i _need_ this to work!

_yes_ i have a modified version of ipt_owner.c which can track down
the full path name of the program.

_yes_ i'm happy with creating more than one per-executable-program-name
rule for instances where sockets are shared between executables
(e.g. they're passed over unix-domain-sockets).

help, help!

l.


-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

