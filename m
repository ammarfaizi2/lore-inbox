Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVFIO6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVFIO6p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 10:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVFIO6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 10:58:45 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:64271 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S261795AbVFIO6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 10:58:43 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] capabilities not inherited
Date: Thu, 9 Jun 2005 14:55:38 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <d89l9a$d3i$1@abraham.cs.berkeley.edu>
References: <Pine.GSO.4.58.0506081513340.22095@chewbacca.arl.wustl.edu> <1118265642.969.12.camel@localhost.localdomain> <d88ba7$hck$1@abraham.cs.berkeley.edu> <1118313167.970.15.camel@localhost.localdomain>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1118328938 13426 128.32.168.222 (9 Jun 2005 14:55:38 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Thu, 9 Jun 2005 14:55:38 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg  wrote:
>tor 2005-06-09 klockan 02:59 +0000 skrev David Wagner:
>> [...] the sendmail attack [...]
>
>I'll look this up but it sounds very weird and I don't see how this
>would happen with this change.

Yup, it was a weird one indeed -- which is part of why I'm concerned.
Take a look at the attack again, then re-read my message.  Maybe my
concerns will make more sense once you refresh your memory about the
setuid capabilities attack?  If not, feel free to ask again, and I'll
try to elaborate.  Here is a pointer to one description of that attack:
    http://www.cs.berkeley.edu/~daw/papers/setuid-usenix02.pdf
    (jump straight to Section 7.1) 
