Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030521AbWHUPEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030521AbWHUPEL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 11:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030525AbWHUPEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 11:04:11 -0400
Received: from mail.suse.de ([195.135.220.2]:32203 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030524AbWHUPEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 11:04:09 -0400
From: Andi Kleen <ak@suse.de>
To: vgoyal@in.ibm.com
Subject: Re: [Fastboot] [PATCH][RFC] x86_64: Reload CS when startup_64 is used.
Date: Mon, 21 Aug 2006 17:04:03 +0200
User-Agent: KMail/1.9.3
Cc: Magnus Damm <magnus.damm@gmail.com>, Magnus Damm <magnus@valinux.co.jp>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com
References: <20060821095328.3132.40575.sendpatchset@cherry.local> <200608211624.11005.ak@suse.de> <20060821144657.GE9549@in.ibm.com>
In-Reply-To: <20060821144657.GE9549@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608211704.03061.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 August 2006 16:46, Vivek Goyal wrote:
> On Mon, Aug 21, 2006 at 04:24:10PM +0200, Andi Kleen wrote:
> > 
> > > Given the idea of relocatable kernel is floating around I would prefer if
> > > we are not bounded by the restriction of loading a kernel in lowest 4G.
> > 
> > There is already other code that requires this. In fact i don't think it can
> > be above 40MB currently.
> >
> 
> But I think Eric's prototype patches for relocatable kernel do get over
> this limitation (Hope I understood the code right). Assuming that relocatable
> kernel patches will be merged down the line, it would be nice not to be
> bound by 4G limitation.

He may have fixed the 40MB issue, but I very much doubt he changed the 2GB
limitation because that would be a major change.

-Andi

