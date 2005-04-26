Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVDZRsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVDZRsM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 13:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVDZRr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 13:47:59 -0400
Received: from peabody.ximian.com ([130.57.169.10]:13973 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261552AbVDZRqw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 13:46:52 -0400
Subject: Re: preempt-count oddities - still looking for comments :)
From: Robert Love <rml@novell.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       kpreempt-tech@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.62.0504261944020.2071@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504232254050.2474@dragon.hyggekrogen.localhost>
	 <Pine.LNX.4.62.0504261929230.2071@dragon.hyggekrogen.localhost>
	 <1114536937.6851.1.camel@betsy>
	 <Pine.LNX.4.62.0504261944020.2071@dragon.hyggekrogen.localhost>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 13:46:30 -0400
Message-Id: <1114537590.6851.3.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-26 at 19:46 +0200, Jesper Juhl wrote:

> I'll update the patch(es) then and use __s32 in the structure and s32 
> elsewhere.

You can actually use s32 everywhere, since the structure is never
exported to user-space...although some architectures already have the
__ugly versions in there.

	Robert Love


