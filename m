Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbTIEBYT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 21:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbTIEBYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 21:24:19 -0400
Received: from colin2.muc.de ([193.149.48.15]:45576 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261829AbTIEBYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 21:24:16 -0400
Date: 5 Sep 2003 03:24:17 +0200
Date: Fri, 5 Sep 2003 03:24:17 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use -fno-unit-at-a-time if gcc supports it
Message-ID: <20030905012417.GA71588@colin2.muc.de>
References: <20030905004710.GA31000@averell> <20030905010535.GV2743@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030905010535.GV2743@vitelus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 06:05:35PM -0700, Aaron Lehmann wrote:
> On Fri, Sep 05, 2003 at 02:47:10AM +0200, Andi Kleen wrote:
> > 
> > Hallo,
> > 
> > gcc 3.4 current has switched to default -fno-unit-at-a-time mode for -O2. 
> > The 3.3-Hammer branch compiler used in some distributions also does this.
> > 
> > Unfortunately the kernel doesn't compile with unit-at-a-time currently,
> 
> Did you mean -funit-at-a-time, rather than the converse?

Yep, sorry for the confusion.

It defaults to -funit-at-a-time now, but the kernel must use
 -fno-unit-at-a-time

-Andi
