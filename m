Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbTFPCju (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 22:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbTFPCju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 22:39:50 -0400
Received: from mta7.srv.hcvlny.cv.net ([167.206.5.22]:16454 "EHLO
	mta7.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S263250AbTFPCjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 22:39:49 -0400
Date: Sun, 15 Jun 2003 22:53:29 -0400
From: Jeff <jeffpc@optonline.net>
Subject: Re: 64-bit fields in struct net_device_stats
In-reply-to: <200306152131.09983.jeffpc@optonline.net>
To: linux-kernel@vger.kernel.org
Message-id: <200306152253.36768.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.2
References: <200306152131.09983.jeffpc@optonline.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 15 June 2003 21:30, Jeff wrote:
<snip>
> These would lock (if
> necessary - 32-bit architectures), add, unlock (if necessary.) 
<snip>

I now realize, that locking is out of the question. Also, it has been 
suggested to use per cpu stats and overflow into a global counter. (Thanks 
Zwane) This might be a better idea - the problem is, the counter won't be 
100% accurate at all times. The degree of inaccuracy will vary with the 
threshold value. On the other hand, if the threshold is relatively low, no 
one will notice the difference these days.

Jeff.

- -- 
Please avoid sending me Word or PowerPoint attachments.
 See http://www.fsf.org/philosophy/no-word-attachments.html 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+7TEswFP0+seVj/4RAidcAJ0UAgHtRK4F1HHp8vOSLVOc5tdtRgCfXTyN
MA5sBYybdjJxwxAwtiUnE8I=
=MbW+
-----END PGP SIGNATURE-----

