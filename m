Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbVCNUNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVCNUNh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 15:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVCNUMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 15:12:19 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:63799 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261827AbVCNUIu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 15:08:50 -0500
Date: Mon, 14 Mar 2005 21:09:00 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: John Kacur <jkacur@rogers.com>
Cc: kai.germaschewski@unh.edu, linux-kernel@vger.kernel.org
Subject: Re: Exuberant ctags can tag files names too
Message-ID: <20050314200900.GC17373@mars.ravnborg.org>
Mail-Followup-To: John Kacur <jkacur@rogers.com>,
	kai.germaschewski@unh.edu, linux-kernel@vger.kernel.org
References: <1110420068.5526.39.camel@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110420068.5526.39.camel@linux.site>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 09:01:08PM -0500, John Kacur wrote:
> Exuberant ctags can tag file names too. I find this extremely useful
> when browsing kernel source, and so would like to share it with
> everyone. (You can now type ":tag oprof.c" for example, and jump to the
> file with that name.)
> 
> I previously sent a patch which naively just appended an "--extra=+f" to
> the ctags line. Here's a much smarter patch that works by first
> querrying if ctags is exuberant, and if so, whether the --extra
> functionality is available before adding the line. Please apply.
> Signed-off-by: John Kacur jkacur@rogers.com

I already applied your original patch (end of January) but only this week
it hit Linus' tree.
I think ctags users will just upgrade if their ctgs does not support
--extra=+f.
At least I will await and see if anyone complains before applying this
patch (btw. line wrapped)

	Sam
