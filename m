Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271184AbTGWRf1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 13:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271185AbTGWRf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 13:35:27 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:20747 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S271184AbTGWRfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 13:35:23 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: 2.4.22-pre7: are security issues solved?
Date: Wed, 23 Jul 2003 17:50:14 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <bfmhsm$n1o$2@abraham.cs.berkeley.edu>
References: <Pine.LNX.4.44.0307212234390.3580-100000@localhost.localdomain> <E19fGMZ-0000Zm-00@gondolin.me.apana.org.au> <20030723033505.145db6b8.davem@redhat.com> <20030723115742.GK150921@niksula.cs.hut.fi>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1058982614 23608 128.32.153.211 (23 Jul 2003 17:50:14 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Wed, 23 Jul 2003 17:50:14 +0000 (UTC)
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva  wrote:
>Further, if you monitor the /proc/tty/driver/serial character counts with
>small enough resolution, I guess you could learn the delays between
>individual key presses when the user enters his password. This can be used
>to further aid the brute force attack (delays between different key pairs
>have different average delays statistically, just as different characters
>have different frequencies in a given language. I think there is a paper on
>this, and someone suggested an attack like this for snooping ssh
>passwords.)

Yes.  The paper describing the attack on SSH is here:
  http://www.cs.berkeley.edu/~daw/papers/ssh-use01.ps
  http://www.cs.berkeley.edu/~daw/papers/ssh-use01.pdf
  Dawn Xiaodong Song, David Wagner, and Xuqing Tian,
  "Timing Analysis of Keystrokes and Timing Attacks on SSH",
  10th USENIX Security Symposium, 2001.
A nice summary can be found here:
  http://linux.oreillynet.com/lpt/a/linux/2001/11/08/ssh_keystroke.html
