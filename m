Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264193AbTDWSat (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 14:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264196AbTDWSat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 14:30:49 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:10252 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264193AbTDWSas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 14:30:48 -0400
Date: Wed, 23 Apr 2003 19:42:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       Stephen Tweedie <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
Message-ID: <20030423194254.A5295@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Linus Torvalds <torvalds@transmeta.com>, Ted Ts'o <tytso@mit.edu>,
	Andreas Gruenbacher <a.gruenbacher@computer.org>,
	Stephen Tweedie <sct@redhat.com>,
	lkml <linux-kernel@vger.kernel.org>,
	lsm <linux-security-module@wirex.com>
References: <1051120322.14761.95.camel@moss-huskers.epoch.ncsc.mil> <20030423191749.A4244@infradead.org> <1051122958.14761.110.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1051122958.14761.110.camel@moss-huskers.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Wed, Apr 23, 2003 at 02:35:59PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 02:35:59PM -0400, Stephen Smalley wrote:
> The idea of using separate attribute names for each security module was
> already discussed at length when I posted the original RFC, and I've
> already made the case that this is not desirable.  Please see the
> earlier discussion.

No.  It's not acceptable that the same ondisk structure has a different
meaning depending on loaded modules.  If the xattrs have a different
meaning they _must_ have a different name.

