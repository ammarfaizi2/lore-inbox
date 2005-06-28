Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVF1UH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVF1UH3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVF1UHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:07:07 -0400
Received: from peabody.ximian.com ([130.57.169.10]:45758 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261356AbVF1UFI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:05:08 -0400
Subject: Re: wrong madvise(MADV_DONTNEED) semantic
From: Robert Love <rml@novell.com>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       Andy Isaacson <adi@hexapodia.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050628200330.GB4453@wohnheim.fh-wedel.de>
References: <20050628134316.GS5044@implementation.labri.fr>
	 <20050628181620.GA1423@hexapodia.org> <1119983300.6745.1.camel@betsy>
	 <20050628185300.GB30079@hexapodia.org> <1119986623.6745.10.camel@betsy>
	 <20050628194128.GM4645@bouh.labri.fr>
	 <20050628200330.GB4453@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=utf-8
Date: Tue, 28 Jun 2005 16:05:11 -0400
Message-Id: <1119989111.6745.21.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 22:03 +0200, Jörn Engel wrote:

> Plus, common sense agrees with posix.  An implementation of madvice
> that doesn't do anything should be perfectly sane and functionally
> equivalent to any other implementation.  Only differences should be in
> performance.
> 
> Dropping dirty pages is a clear functional difference.

I like the idea (I think someone suggested this early on) of renaming
the current MADV_DONTNEED to MADV_FREE and then adding a correct
MADV_DONTNEED.

And, as I said, the man page needs clarification.

	Robert Love


