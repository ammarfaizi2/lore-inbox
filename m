Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVBVRwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVBVRwa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 12:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVBVRwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 12:52:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40119 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261165AbVBVRw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 12:52:26 -0500
Date: Tue, 22 Feb 2005 17:52:25 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch -mm series] ia64 specific /dev/mem handlers
Message-ID: <20050222175225.GK28741@parcelfarce.linux.theplanet.co.uk>
References: <16923.193.128608.607599@jaguar.mkp.net> <20050222020309.4289504c.akpm@osdl.org> <yq0ekf8lksf.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0ekf8lksf.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2005 at 09:41:04AM -0500, Jes Sorensen wrote:
> >> + if (page->flags & PG_uncached)
> 
> Andrew> dude.  That ain't gonna work ;)
> 
> Pardon my lack of clue, but why not?

I think you're supposed to always use test_bit() to check page flags

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
