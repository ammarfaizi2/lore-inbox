Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWDKXGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWDKXGp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 19:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWDKXGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 19:06:45 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:54940 "EHLO mail.acc.umu.se")
	by vger.kernel.org with ESMTP id S1751335AbWDKXGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 19:06:44 -0400
Date: Wed, 12 Apr 2006 01:06:42 +0200
From: David Weinehall <tao@acc.umu.se>
To: Ramakanth Gunuganti <rgunugan@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPL issues
Message-ID: <20060411230642.GV23222@vasa.acc.umu.se>
Mail-Followup-To: Ramakanth Gunuganti <rgunugan@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20060411063127.97362.qmail@web54314.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060411063127.97362.qmail@web54314.mail.yahoo.com>
User-Agent: Mutt/1.4.2.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, simplified rules; if you follow them you should generally be OK:

1. Changes to kernel --> GPL

2. Kernel driver --> GPL

3. Userspace code that uses interfaces that was not exposed to userspace
before you change the kernel --> GPL (but don't do it; there's almost
always a reason why an interface is not exported to userspace)

4. Userspace code that only uses existing interfaces --> choose
license yourself (but of course, GPL would be nice...)

5. Userspace code that depends on interfaces you added to the kernel
--> consult a lawyer (if this interface is something completely new,
you can *probably* use your own license for the userland part; if the
interface is more or less a wrapper of existing functionality, GPL)

And of course, I'm not a lawyer either...


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
