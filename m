Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264054AbUGAGPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbUGAGPa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 02:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbUGAGPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 02:15:30 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:8881 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264054AbUGAGP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 02:15:29 -0400
Subject: Re: [Lhms-devel] new memory hotremoval patch
From: Dave Hansen <haveblue@us.ibm.com>
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <20040701055836.A688F70A92@sv1.valinux.co.jp>
References: <20040630111719.EBACF70A92@sv1.valinux.co.jp>
	 <1088640671.5265.1017.camel@nighthawk>
	 <20040701030543.8CE8F70A92@sv1.valinux.co.jp>
	 <1088659723.10720.3.camel@nighthawk>
	 <20040701055836.A688F70A92@sv1.valinux.co.jp>
Content-Type: text/plain
Message-Id: <1088662503.10720.6.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 30 Jun 2004 23:15:03 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-30 at 22:58, IWAMOTO Toshihiro wrote:
> Such code only appears only in try_to_unuse and do_swap_page.  These
> functions aren't for page caches.
> 
> I'm confused.  Weren't you talking about page cache code?

Ahh.  Gotcha.  MI saw some of the BUG_ON()s and some of the swap code
and misinterpreted where the flag was being used.  

-- Dave

