Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbTEVXSD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 19:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbTEVXSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 19:18:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:40672 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263380AbTEVXSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 19:18:03 -0400
Date: Thu, 22 May 2003 16:29:13 -0700 (PDT)
Message-Id: <20030522.162913.115921853.davem@redhat.com>
To: schlicht@uni-mannheim.de
Cc: akpm@digeo.com, mfc@krycek.org, linux-kernel@vger.kernel.org
Subject: Re: Error during compile of 2.5.69-mm8
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305230128.06412.schlicht@uni-mannheim.de>
References: <20030522160218.57b828db.akpm@digeo.com>
	<20030522.160531.59667592.davem@redhat.com>
	<200305230128.06412.schlicht@uni-mannheim.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thomas Schlichter <schlicht@uni-mannheim.de>
   Date: Fri, 23 May 2003 01:28:06 +0200

   On May 23, David S. Miller wrote:
   > Yoshfuji posted a patch on linux-kernel to fix this already.
   
   Sorry, I must have missed this patch - that would have made my work
   obsolete - 
   but I'd like to see how that supports all the other
   SET_MODULE_OWNER calls from all the other places...
   
They also should be converted to explicit ->owner references.
