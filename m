Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbVHZVZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbVHZVZN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 17:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbVHZVZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 17:25:13 -0400
Received: from ms-smtp-03-smtplb.rdc-nyc.rr.com ([24.29.109.7]:34497 "EHLO
	ms-smtp-03.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S965173AbVHZVZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 17:25:12 -0400
Date: Fri, 26 Aug 2005 21:34:08 +0000
From: Kent Robotti <dwilson24@nyc.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Initramfs and TMPFS!
Message-ID: <20050826213408.GA1001@Linux.nyc.rr.com>
Reply-To: dwilson24@nyc.rr.com
References: <200508260139.j7Q1dFME000555@ms-smtp-03.rdc-nyc.rr.com> <20050826190647.GA12296@taniwha.stupidest.org> <20050826200851.GA851@Linux.nyc.rr.com> <20050826202226.GA13807@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050826202226.GA13807@taniwha.stupidest.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2005 at 01:22:26PM -0700, Chris Wedgwood wrote:
> On Fri, Aug 26, 2005 at 08:08:51PM +0000, Kent Robotti wrote:
> 
> > Overmount_rootfs shouldn't take place until you know for sure the
> > kernel detects an initramfs.
> 
> Actually, it was a deliberate decision to *always* overmount after
> some discussion with people.
 
Ideally, I don't know why you would want to overmount unless the
kernel detects an initramfs. 

> It's not a clean solution and the overall goals aren't clear here so
> it was never submitted for inclusion --- an the fact is 99.9% of users
> simply don't need or care for this.

I know the patch is just a quick and simple way to use tmpfs for 
initramfs, and it seems to work.

But, it would be nice if were cleaned up for that less than one percent.

