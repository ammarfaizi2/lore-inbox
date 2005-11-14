Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbVKNSCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbVKNSCz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 13:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVKNSCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 13:02:55 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:53920 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751215AbVKNSCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 13:02:55 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Mon, 14 Nov 2005 18:02:45 +0000
User-Agent: KMail/1.9
Cc: Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
References: <20051114133802.38755.qmail@web50205.mail.yahoo.com> <1131979779.5751.17.camel@localhost.localdomain>
In-Reply-To: <1131979779.5751.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511141802.45788.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 November 2005 14:49, Alan Cox wrote:
> On Llu, 2005-11-14 at 05:38 -0800, Alex Davis wrote:
> > This will break ndiswrapper. Why can't we just leave this in and let
> > people choose?
>
> If we spent our entire lives waiting for people to fix code nothing
> would ever happen. Removing 8K stacks is a good thing to do for many
> reasons. The ndis wrapper people have known it is coming for a long
> time, and if it has a lot of users I'm sure someone in that community
> will take the time to make patches.

I honestly don't know if this is the case, but is it conceivable that no patch 
could be written to resolve this, because the Windows drivers themselves only 
respect Windows stack limits (which are presumably still 8K?).

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
