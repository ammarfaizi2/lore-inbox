Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262565AbUKLQlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbUKLQlc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 11:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbUKLQkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 11:40:00 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:29603 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262565AbUKLQia
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 11:38:30 -0500
Subject: Re: 2.6.10-rc1-mm5: REISER4_LARGE_KEY is still selectable
From: Vladimir Saveliev <vs@namesys.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20041112132343.GF2310@stusta.de>
References: <20041111012333.1b529478.akpm@osdl.org>
	 <20041111165045.GA2265@stusta.de>
	 <1100243278.1490.42.camel@tribesman.namesys.com>
	 <20041112132343.GF2310@stusta.de>
Content-Type: text/plain
Message-Id: <1100274731.1490.63.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 12 Nov 2004 19:37:59 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Fri, 2004-11-12 at 16:23, Adrian Bunk wrote:
> On Fri, Nov 12, 2004 at 10:07:59AM +0300, Vladimir Saveliev wrote:
> 
> > Hello
> 
> Hi Vladimir,
> 
> > On Thu, 2004-11-11 at 19:50, Adrian Bunk wrote:
> > > REISER4_LARGE_KEY is still selectable in reiser4-include-reiser4.patch 
> > > (and we agreed that it shouldn't be).
> > 
> > Sorry, concerning this problem - what did we agree about?
> 
> depending on the setting of REISER4_LARGE_KEY, there are two binary 
> incompatible variants of reiser4 (which can't be both supported by one 
> kernel).
> 
> Therefore, REISER4_LARGE_KEY shouldn't be asked but always enabled.
> 

One may create reiser4 with so called short keys. In current state of
code enabling LARGE_KEY will make impossible to use that filesystem.

So, while reiser4 is not able to distinguish key type on fly we let user
to look for and undefive REISER4_LARGE_KEY macro directly in source
code?

> cu
> Adrian

