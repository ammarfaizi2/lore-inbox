Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWDDRco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWDDRco (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 13:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWDDRco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 13:32:44 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:45759 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750747AbWDDRco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 13:32:44 -0400
Date: Tue, 4 Apr 2006 18:32:40 +0100 (BST)
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: Takashi Iwai <tiwai@suse.de>
cc: Jan Niehusmann <jan@gondor.com>, Ken Moffat <zarniwhoop@ntlworld.com>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] Slab corruptions & Re: 2.6.17-rc1: Oops in sound
 applications
In-Reply-To: <s5hlkul72rv.wl%tiwai@suse.de>
Message-ID: <Pine.LNX.4.63.0604041827290.8756@deepthought.mydomain>
References: <Pine.LNX.4.63.0604032155220.17605@deepthought.mydomain>
 <20060404133814.GA11741@knautsch.gondor.com> <s5hlkul72rv.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809536-1923691522-1144171960=:8756"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809536-1923691522-1144171960=:8756
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT

On Tue, 4 Apr 2006, Takashi Iwai wrote:

> 
> Could you try the patch below by OGAWA Hirofumi
> <hirofumi@mail.parknet.co.jp>?

 I'm not sure if this is helping or not - a few hours ago, I took a 
couple of new things out of my .config (vga scrollback, new rtc) and the 
oops only happened when I opened a second tab in firefox (that is, start 
the sound app, then start firefox, then open another tab).  With this 
patch, it oopsed when I opened a _third_ tab.

 I guess something else is involved.

Ken
-- 
das eine Mal als Tragödie, das andere Mal als Farce
---1463809536-1923691522-1144171960=:8756--
