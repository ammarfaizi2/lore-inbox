Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265709AbTFNTwF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 15:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265712AbTFNTwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 15:52:05 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:20458 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S265709AbTFNTwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 15:52:03 -0400
Date: Sat, 14 Jun 2003 22:05:38 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Stacy Woods <stacyw@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Bugs sitting in the NEW state for more than 28 days
Message-ID: <20030614200538.GC4972@wohnheim.fh-wedel.de>
References: <3EEA15EC.7080203@us.ibm.com> <20030614194026.GA3733@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030614194026.GA3733@mars.ravnborg.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 June 2003 21:40:26 +0200, Sam Ravnborg wrote:
> On Fri, Jun 13, 2003 at 02:20:28PM -0400, Stacy Woods wrote:
> > There are 125 bugs sitting in the NEW state for more than 28 days
> > 
> > 228  Other      Other      bugme-janitors@lists.osdl.org
> > Make pdfdocs/psdocs/htmldoc fail in 2.5.54
> 
> Fixed in linus-latest.
> Note that the changes to kernel-doc make it spit out warnings for
> all parameters in a funtion which is not documented.
> A better solution might be to spit out warnings for parameters
> documented but not present.
> My perl skills did not suffer for this.
> 
> The real errors were in one .tmpl files and one .c file,
> The other changes in kernel-doc just helped me identifying the root
> cause.

Close the bug.

> > 485  Other      Other      bugme-janitors@lists.osdl.org
> > "make rpm" fails; no kernel-2.5.65/debugfiles.list
> 
> Alan Cox checked in a correction that was present in 2.5.66.
> I have tried "make rpm" with 2.5.70 with success.
> Can be closed.

dito.

Any reason why you didn't do this yourself, except for the general
lazyness of a programmer?

Jörn

-- 
Victory in war is not repetitious.
-- Sun Tzu
