Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbTEFHiI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 03:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbTEFHiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 03:38:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56549 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262435AbTEFHiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 03:38:08 -0400
Date: Mon, 05 May 2003 23:43:14 -0700 (PDT)
Message-Id: <20030505.234314.98873309.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] svc's possibly race with sigd
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305052253.h45MrUTj020679@locutus.cmf.nrl.navy.mil>
References: <200305052253.h45MrUTj020679@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Mon, 5 May 2003 18:53:30 -0400

   pretty sure the author wanted the wait queues in place before
   talking to sigd which might cause a wakeup on the vcc in question.
   this race is VERY unlikely, since going down to user space and back
   is quite slow.
   
Applied, thanks chas.
