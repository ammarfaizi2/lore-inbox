Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262525AbUKLNFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbUKLNFS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 08:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbUKLNFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 08:05:18 -0500
Received: from user-10mt71s.cable.mindspring.com ([65.110.156.60]:24623 "EHLO
	localhost") by vger.kernel.org with ESMTP id S262525AbUKLNEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 08:04:21 -0500
Date: Fri, 12 Nov 2004 08:02:45 -0500
From: David Roundy <droundy@abridgegame.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] darcs mirror of the linux kernel repository
Message-ID: <20041112130245.GF23339@abridgegame.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20041110124158.GD31123@abridgegame.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041110124158.GD31123@abridgegame.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Nov 2004 22:19:27 +0100, Pavel Machek wrote:
> Would it be possible to get data from www.bkbits.net so that complete
> history is preserved?

Full history could be preserved, but I don't think that getting it from the
web interface would be polite, and I can't run bk myself (for obvious
reasons).

I could hack up a sketch of how I'd go about getting the full history.
Crudely speaking, I'd just need a couple of functions: one telling me the
parents of a given version, and one fetching a given version.  And of
course, finding the author/date/comments for each version.  If someone else
were willing to implement those two functions, I could sketch out how the
darcs side of things.  Obviously renames wouldn't be preserved with just
those functions, but that's not a huge loss.  And also, the conversion
process would be painfully slow.
-- 
David Roundy
http://www.darcs.net
