Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262385AbUKVUu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbUKVUu6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 15:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbUKVUui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 15:50:38 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:61876 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S262384AbUKVUay
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 15:30:54 -0500
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: sparse segfaults
Date: Mon, 22 Nov 2004 21:30:45 +0100
User-Agent: KMail/1.6.2
Cc: Linus Torvalds <torvalds@osdl.org>, Mitchell Blank Jr <mitch@sfgoth.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
References: <20041120143755.E13550@flint.arm.linux.org.uk> <20041122183956.GA50325@gaz.sfgoth.com> <Pine.LNX.4.58.0411221047140.20993@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411221047140.20993@ppc970.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411222130.46247.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect (but don't have any real argument to back that up) is that the
> gcc "extended lvalues" fell out as a side effect from how gcc ended up
> doing some random semantic tree parsing, and it wasn't really "designed"
> per se, as much as just a random implementation detail. Then somebody 
> noticed it, and said "cool" and documented it.

Generalized lvalues have been removed.  Check out
http://gcc.gnu.org/ml/gcc/2004-11/msg00604.html

All the best,

Duncan.
