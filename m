Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266347AbUGJSyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266347AbUGJSyK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 14:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266348AbUGJSyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 14:54:09 -0400
Received: from [213.146.154.40] ([213.146.154.40]:17596 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266347AbUGJSyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 14:54:07 -0400
Date: Sat, 10 Jul 2004 19:54:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       jmerkey@comcast.net, Pete Harlan <harlan@artselect.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Ext3 File System "Too many files" with snort
Message-ID: <20040710185403.GA19329@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hans Reiser <reiser@namesys.com>, Dave Jones <davej@redhat.com>,
	jmerkey@comcast.net, Pete Harlan <harlan@artselect.com>,
	linux-kernel@vger.kernel.org
References: <070920041920.2370.40EEEFFD000B341B000009422200763704970A059D0A0306@comcast.net> <40EF797E.6060601@namesys.com> <20040710083347.GC6386@redhat.com> <40F02963.5040500@namesys.com> <20040710174432.GA18719@infradead.org> <40F02E05.8090401@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F02E05.8090401@namesys.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 10:57:25AM -0700, Hans Reiser wrote:
> RHEL applies all sorts of patches that have not been tested in mainline, 
> and then tells its customers that it is more stable when the reverse is 
> true.  RHEL should pick a stable mainline kernel 6 weeks after it has 
> proven stable, and use it.

I haven't heard that big complains about RH stability yet, but applying
random vendor patches increases Q&A costs - apparently RH seems to be quite
successfull with that business model anyway.

> Their not applying reiserfs bugfixes that are present in the mainline is 
> just more evidence that they don't care about stability as much as 
> marketing.

Why the heck should they waste ressources with backporting reiserfs fixes
if they don't support it?  If you care for reiserfs stability in RHEL send
them patches, that's what SGI did for XFS in Fedora Core 2.

