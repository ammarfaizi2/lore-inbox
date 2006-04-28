Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751795AbWD1S1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbWD1S1p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 14:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWD1S1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 14:27:45 -0400
Received: from canuck.infradead.org ([205.233.218.70]:13037 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751795AbWD1S1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 14:27:44 -0400
Subject: Re: [PATCH] 'make headers_install' kbuild target.
From: David Woodhouse <dwmw2@infradead.org>
To: Rob Landley <rob@landley.net>
Cc: Adrian Bunk <bunk@stusta.de>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200604281415.53325.rob@landley.net>
References: <1145672241.16166.156.camel@shinybook.infradead.org>
	 <20060422142853.GB25926@mars.ravnborg.org>
	 <20060422145000.GF5010@stusta.de>  <200604281415.53325.rob@landley.net>
Content-Type: text/plain
Date: Fri, 28 Apr 2006 19:27:39 +0100
Message-Id: <1146248859.11909.565.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-28 at 14:15 -0400, Rob Landley wrote:
> Fedora recently migrated from a linux-kernel-headers package that smells a bit 
> like Mazur's to the glibc-kernheaders package.

Fedora used to be on an ancient version of the headers, forked and
manually sanitised from 2.4 some time ago and manually (but
inconsistently) updated to date with new syscalls &c as and when bugs
got filed against the package.

As of two days ago, Fedora is using the result of 'make headers_install'
instead. Speaking as maintainer of Fedora's glibc-kernheaders, I think
it's a massive improvement, 

Other distributions look like they should be able to change too -- the
whole point in approaching them before implementing this was to confirm
that they'd be happy with it. I don't know _when_ that'll happen though.
Obviously it makes sense for them to wait while I use Fedora rawhide as
a test bed.

-- 
dwmw2

