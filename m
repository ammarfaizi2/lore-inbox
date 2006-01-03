Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWACR0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWACR0s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 12:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWACR0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 12:26:48 -0500
Received: from ns2.suse.de ([195.135.220.15]:38637 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750784AbWACR0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 12:26:47 -0500
From: Andi Kleen <ak@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 23/26] gitignore: x86_64 files
Date: Tue, 3 Jan 2006 18:26:41 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20060103132035.GA17485@mars.ravnborg.org> <p73wthhi7v9.fsf@verdi.suse.de> <20060103171517.GB20001@mars.ravnborg.org>
In-Reply-To: <20060103171517.GB20001@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601031826.42028.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 January 2006 18:15, Sam Ravnborg wrote:
> On Tue, Jan 03, 2006 at 05:39:06PM +0100, Andi Kleen wrote:
> > Sam Ravnborg <sam@ravnborg.org> writes:
> > 
> > > From: Brian Gerst <bgerst@didntduck.org>
> > > Date: 1135744791 -0500
> > > 
> > > Add filters for x86_64 generated files.
> > 
> > Please don't submit this patch. If anything such ignore lists
> > for specific SVMs should be in a central place, but not spread
> > everywhere.
> 
> If we go for a central '.gitignore' then we will most probarly see a
> file that is only added entries to, not removed. We saw that in the bk
> days.

And what's the problem with that?

> Today there are 23 .gitignores in the kernel - including the ones
> from this patchset.

And next year .cvsignores and .svnignores and .hgignores and 
.whateveriscurrentlyenvoguesvmignores ?

> In may other cases we avoid this central point of information disaster
> and we shall avoid it for .gitignore too.

Please do that outside arch/x86_64 then.

-Andi
