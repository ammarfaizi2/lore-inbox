Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUBKI0p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 03:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbUBKI0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 03:26:45 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:3463 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S263679AbUBKI0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 03:26:44 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Reserved page flaging of 2.4 kernel memory changed recently?
Date: Wed, 11 Feb 2004 16:36:18 +0800
User-Agent: KMail/1.5.4
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
References: <200402050941.34155.mhf@linuxmail.org> <200402100625.41288.mhf@linuxmail.org> <20040210185137.GD4478@dualathlon.random>
In-Reply-To: <20040210185137.GD4478@dualathlon.random>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402111636.18779.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 February 2004 02:51, Andrea Arcangeli wrote:
> On Tue, Feb 10, 2004 at 11:24:01PM +0800, Michael Frank wrote:
> > +	ClearPageNosave(page);
> 
> why this clearpagenosave? looks superflous, you're not doing it in the
> normal zone anyways.

OK, this gets removed.

Regards
Michael

