Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264415AbTIJOYV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 10:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264468AbTIJOYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 10:24:21 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:21404 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S264415AbTIJOYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 10:24:18 -0400
Date: Wed, 10 Sep 2003 15:23:08 +0100
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Mitchell Blank Jr <mitch@sfgoth.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oops_in_progress is unlikely()
Message-ID: <20030910142308.GL932@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>, Mitchell Blank Jr <mitch@sfgoth.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20030907064204.GA31968@sfgoth.com> <20030907221323.GC28927@redhat.com> <20030910142031.GB2589@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910142031.GB2589@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 04:20:31PM +0200, Pavel Machek wrote:

 > > none of this patch seems to touch particularly performance critical code.
 > > Is it really worth adding these macros to every if statement in the kernel?
 > > There comes a point where readability is lost, for no measurable gain.
 > 
 > Perhaps we should have macros ifu() and ifl(), that would be used as a
 > plain if, just with likelyness-indication? That way we could have it
 > in *every* statement and readability would not suffer that much...

You've got to be kidding.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
