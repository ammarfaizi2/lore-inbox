Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263546AbTDMQLx (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 12:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263549AbTDMQLx (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 12:11:53 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:1031 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263546AbTDMQLx (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 12:11:53 -0400
Date: Sun, 13 Apr 2003 18:23:38 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: lk-changelog.pl 0.96
Message-ID: <20030413162338.GC22268@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030413104943.433A37EBE4@merlin.emma.line.org> <20030413144218.GB21855@renegade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030413144218.GB21855@renegade>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Apr 2003, Zack Brown wrote:

> On Sun, Apr 13, 2003 at 12:49:43PM +0200, Matthias Andree wrote:
> > This is a semi-automatic announcement.
> > 
> > lk-changelog.pl aka. shortlog version 0.96 has been released.
> 
> I think these emails from Alan and Linus actually appear in changelogs.

They are caught by the recently added regexp parser and don't need to be
listed explicitly. If you're running ./lk-changelog.pl --selftest, it'll
print a list of addresses that are matched by a regexp (the printout
actually suggests the opposite, but that's an implementation detail;
these lookups are tuned for speed).
