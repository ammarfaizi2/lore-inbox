Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263845AbTEZCFk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 22:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263848AbTEZCFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 22:05:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14471 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263845AbTEZCFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 22:05:39 -0400
Date: Sun, 25 May 2003 19:18:18 -0700 (PDT)
Message-Id: <20030525.191818.48503212.davem@redhat.com>
To: schlicht@uni-mannheim.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error during compile of 2.5.69-mm8
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305241637.07395.schlicht@uni-mannheim.de>
References: <200305230538.38946.schlicht@uni-mannheim.de>
	<20030522.213217.27796203.davem@redhat.com>
	<200305241637.07395.schlicht@uni-mannheim.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thomas Schlichter <schlicht@uni-mannheim.de>
   Date: Sat, 24 May 2003 16:36:59 +0200
   
   I also attached a patch that fixes the SET_MODULE_OWNER thing for
   net/ipv4/ by using static initializers

I can't apply these patches, there are errors.  You remove
the esp4_type->owner setting, but don't put the static initializer
in there.

I suppose you do test the changes you make in your patches, right?
What was the test you made to make sure the esp4_type module ownership
was set correctly? :-)
