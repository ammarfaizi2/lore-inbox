Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVARLq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVARLq0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 06:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVARLq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 06:46:26 -0500
Received: from relay.muni.cz ([147.251.4.35]:20458 "EHLO tirith.ics.muni.cz")
	by vger.kernel.org with ESMTP id S261209AbVARLqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 06:46:25 -0500
Date: Tue, 18 Jan 2005 12:45:30 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: Christoph Hellwig <hch@infradead.org>,
       Jakob Oestergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org,
       kruty@fi.muni.cz
Subject: Re: XFS: inode with st_mode == 0
Message-ID: <20050118114530.GC27995@fi.muni.cz>
References: <20041209125918.GO9994@fi.muni.cz> <20041209135322.GK347@unthought.net> <20041209215414.GA21503@infradead.org> <20041221184304.GF16913@fi.muni.cz> <20041222084158.GG347@unthought.net> <20041222182344.GB14586@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041222182344.GB14586@infradead.org>
User-Agent: Mutt/1.4.1i
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
: I have a better patch than the one I gave you (attached below).  If you
: send me a mail with steps to reproduce your remaining problems I'll put
: this very high on my TODO list after christmas.  Btw, any chance you could
: try XFS CVS (which is at 2.6.9) + the patch below instead of plain 2.6.9,
: there have been various other fixes in the last months.
: 
	Just FWIW, this patch (applied to 2.6.10) seems to fix the problem
for me. I was not able to reproduce it by running my test script for ~24 hours.

	Thanks!

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
