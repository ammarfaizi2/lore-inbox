Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbTHYEO0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 00:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbTHYEO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 00:14:26 -0400
Received: from unthought.net ([212.97.129.24]:43447 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261440AbTHYEOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 00:14:25 -0400
Date: Mon, 25 Aug 2003 06:14:23 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Jamie Lokier <jamie@shareable.org>
Cc: Jim Houston <jim.houston@comcast.net>, linux-kernel@vger.kernel.org,
       jim.houston@ccur.com
Subject: Re: [PATCH] Pentium Pro - sysenter - doublefault
Message-ID: <20030825041423.GB29987@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Jamie Lokier <jamie@shareable.org>,
	Jim Houston <jim.houston@comcast.net>, linux-kernel@vger.kernel.org,
	jim.houston@ccur.com
References: <1061498486.3072.308.camel@new.localdomain> <20030825040514.GA20529@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030825040514.GA20529@mail.jlokier.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 05:05:14AM +0100, Jamie Lokier wrote:
...
> Jim you can answer this as you have such a Ppro.  Could you please run
> this very simple userspace program for me, and report the result?
> 
> 	int main() { __asm__ ("sysenter"); return 0; }

I tested on two boxes:

Stepping 1 ppro:  SIGSEGV
Stepping 7 ppro:  SIGSEGV

If you need additional info, please just ask.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
