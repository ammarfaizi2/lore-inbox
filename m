Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbVKQOm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbVKQOm0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 09:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbVKQOm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 09:42:26 -0500
Received: from cantor.suse.de ([195.135.220.2]:6537 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750946AbVKQOmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 09:42:25 -0500
From: Andi Kleen <ak@suse.de>
To: "Wed, 16 Nov 2005 21:46:05 +0100" <grundig@teleline.es>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Thu, 17 Nov 2005 03:01:00 +0100
User-Agent: KMail/1.8.2
Cc: Benjamin LaHaise <bcrl@kvack.org>, bunk@stusta.de, arjan@infradead.org,
       oliver@neukum.org, jmerkey@utah-nac.org, joern@wohnheim.fh-wedel.de,
       alex14641@yahoo.com, linux-kernel@vger.kernel.org
References: <20051116005034.73421.qmail@web50210.mail.yahoo.com> <20051116190334.GC982@kvack.org> <20051116214605.545d1e4e.grundig@teleline.es>
In-Reply-To: <20051116214605.545d1e4e.grundig@teleline.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200511170301.01910.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 November 2005 21:46, Wed, 16 Nov 2005 21:46:05 +0100 wrote:
> El Wed, 16 Nov 2005 14:03:34 -0500,
> Benjamin LaHaise <bcrl@kvack.org> escribió:
> 
> > We could implement a stack guard page for the transition period, so that 
> 
> CONFIG_DEBUG_STACKOVERFLOW doesn't do that but it looks useful too.
> 
> Does CONFIG_DEBUG_STACKOVERFLOW harm performance a lot? (doesn't 
> look like that for a newbie's eye)

No, it's very cheap. In fact it could be probably enabled by default.

-Andi

P.S.: Can you please chose a less irritating realname?

 
