Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270709AbTHAK3C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 06:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270714AbTHAK3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 06:29:01 -0400
Received: from smtp0.libero.it ([193.70.192.33]:12165 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S270709AbTHAK2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 06:28:54 -0400
Subject: Re: Kernel 2.6.0-test2-mm2 Still No Penguin Logo
From: Flameeyes <daps_mls@libero.it>
To: Ronald Jerome <imun1ty@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030801005737.72096.qmail@web13301.mail.yahoo.com>
References: <20030801005737.72096.qmail@web13301.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1059733764.1085.0.camel@laurelin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 01 Aug 2003 12:29:25 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-01 at 02:57, Ronald Jerome wrote:
> Logo has dissapeared after 2.6.0-test1-mm2.
Is the missing of fbdev patch.
at line 328 of drivers/video/cfbimgblt.c change

   328          } else if (image->depth == bpp)

to

   328          } else if (image->depth <= bpp)

and it will works again.
-- 
Flameeyes <dgp85@users.sf.net>

