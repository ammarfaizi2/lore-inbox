Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWJWUWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWJWUWM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWJWUWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:22:12 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:58772
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1750831AbWJWUWL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:22:11 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] do not compile AMD Geode's hwcrypto driver as a module per default
Date: Mon, 23 Oct 2006 22:21:14 +0200
User-Agent: KMail/1.9.5
References: <20061021081745.GA6193@zmei.tnic> <1161602705.19388.22.camel@localhost.localdomain>
In-Reply-To: <1161602705.19388.22.camel@localhost.localdomain>
Cc: Borislav Petkov <petkov@math.uni-muenster.de>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       info-linux@geode.amd.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610232221.14265.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 October 2006 13:25, Alan Cox wrote:
> Ar Sad, 2006-10-21 am 10:17 +0200, ysgrifennodd Borislav Petkov:
> > This one should be probably made dependent on some #define saying that the cpu
> > is an AMD and has the LX Geode crypto hardware built in. Turn it off for now.
> 
> That makes no real sense. Most kernel selections are "run on lots of
> processor types", we thus want as much as possible modular, built and
> available.
> 
> The existing defaults seem quite sane.

I can only second that.
Building it as a module does not hurt, except few k disk space.
But that does not really hurt, given today's disk sizes. ;)
And if you have a small disk, you can still disable it.

-- 
Greetings Michael.
