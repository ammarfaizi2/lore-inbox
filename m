Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262664AbVA0Qxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262664AbVA0Qxp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 11:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbVA0QwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 11:52:15 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:48302 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262663AbVA0Qvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 11:51:50 -0500
Date: Thu, 27 Jan 2005 08:51:45 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
Cc: Steve Lord <lord@xfs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Preempt & Xfs Question
Message-ID: <20050127165145.GA13181@taniwha.stupidest.org>
References: <41F91470.6040204@tiscali.de> <41F908C4.4080608@xfs.org> <20050127154017.GA12493@taniwha.stupidest.org> <41F9290E.1050209@tiscali.de> <20050127155338.GB12493@taniwha.stupidest.org> <41F931CD.5030401@tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F931CD.5030401@tiscali.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 06:24:13PM +0000, Matthias-Christian Ott wrote:

> Well calling such a internal function (__function) is not a cleaning
> coding style but works best :-) .

__foo does NOT mean it's an internal function necessarily or that it's
unclean to use it (sadly Linux has pretty vague (nothing consistent)
rules on how to interpret __foo versus foo really.

> Combined with the current_cpu() fixes I mentioned, it looks like
> this:

(1) your patch is mangled/wrapped

(2) this is fixed in CVS already (for maybe a week or so now?)

> I'll submit it to the mailinglist as a seperate patch, so Linus can
> apply it to the current Kernel.

XFS patches/suggestions should go to linux-xfs@oss.sgi.com and the
maintainers there can comment as needed.
