Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbTEWBFh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 21:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263570AbTEWBFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 21:05:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27617 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263540AbTEWBFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 21:05:34 -0400
Date: Thu, 22 May 2003 18:16:46 -0700 (PDT)
Message-Id: <20030522.181646.26291321.davem@redhat.com>
To: schlicht@uni-mannheim.de
Cc: akpm@digeo.com, mfc@krycek.org, linux-kernel@vger.kernel.org
Subject: Re: Error during compile of 2.5.69-mm8
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305230306.54981.schlicht@uni-mannheim.de>
References: <200305230213.39460.schlicht@uni-mannheim.de>
	<20030522.172304.08334616.davem@redhat.com>
	<200305230306.54981.schlicht@uni-mannheim.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thomas Schlichter <schlicht@uni-mannheim.de>
   Date: Fri, 23 May 2003 03:06:45 +0200

   So I attached a very small patch that will help braking 
   nothing... ;-)

No it breaks everything, module.h is always included
before netdevice.h.

This isn't how to solve this problem, I showed you how it
can be done by definiting type-specific macros.
