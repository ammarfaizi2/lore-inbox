Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWINPXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWINPXJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 11:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWINPXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 11:23:09 -0400
Received: from mx1.suse.de ([195.135.220.2]:34517 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750756AbWINPXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:23:08 -0400
From: Andi Kleen <ak@suse.de>
To: "Albert Cahalan" <acahalan@gmail.com>
Subject: Re: [PATCH] i386/x86_64 signal handler arg fixes
Date: Thu, 14 Sep 2006 15:40:44 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Linus Torvalds" <torvalds@osdl.org>, hpa@zytor.com
References: <787b0d920609140134j5935c743kae4af8d51eea2a90@mail.gmail.com> <200609141211.53087.ak@suse.de> <787b0d920609140801r452ff7d7vdc2d96865836eefc@mail.gmail.com>
In-Reply-To: <787b0d920609140801r452ff7d7vdc2d96865836eefc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609141540.44984.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I guess that should be deleted then?

Yes. I will delete it right now. Thanks for the notice.
 
> Currently you remap signals. Whatever you do this for
> regparm(0) should also be done for regparm(3).

Not sure I parse you here. You're asking how to fix the regparm(3)
case?

-Andi


