Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbWACRP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWACRP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 12:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWACRP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 12:15:28 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:60171 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932453AbWACRP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 12:15:28 -0500
Date: Tue, 3 Jan 2006 18:15:17 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/26] gitignore: x86_64 files
Message-ID: <20060103171517.GB20001@mars.ravnborg.org>
References: <20060103132035.GA17485@mars.ravnborg.org> <11362947263966@foobar.com> <p73wthhi7v9.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73wthhi7v9.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 05:39:06PM +0100, Andi Kleen wrote:
> Sam Ravnborg <sam@ravnborg.org> writes:
> 
> > From: Brian Gerst <bgerst@didntduck.org>
> > Date: 1135744791 -0500
> > 
> > Add filters for x86_64 generated files.
> 
> Please don't submit this patch. If anything such ignore lists
> for specific SVMs should be in a central place, but not spread
> everywhere.

If we go for a central '.gitignore' then we will most probarly see a
file that is only added entries to, not removed. We saw that in the bk
days.
Today there are 23 .gitignores in the kernel - including the ones
from this patchset.
In may other cases we avoid this central point of information disaster
and we shall avoid it for .gitignore too.

	Sam
