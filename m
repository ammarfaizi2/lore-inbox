Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266849AbSLPRQy>; Mon, 16 Dec 2002 12:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266844AbSLPRQx>; Mon, 16 Dec 2002 12:16:53 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:32779 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266849AbSLPRQh>;
	Mon, 16 Dec 2002 12:16:37 -0500
Date: Mon, 16 Dec 2002 09:22:17 -0800
From: Greg KH <greg@kroah.com>
To: Ben Collins <bcollins@debian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Larry McVoy <lm@bitmover.com>
Subject: Re: Notification hooks
Message-ID: <20021216172216.GB15425@kroah.com>
References: <20021216171218.GV504@hopper.phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216171218.GV504@hopper.phunnypharm.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 12:12:18PM -0500, Ben Collins wrote:
> Linus, is there anyway I can request a hook so that anything that
> changes drivers/ieee1394/ in your repo sends me an email with the diff
> for just the files in that directory, and the changeset log? Is this
> something that bkbits can do?

Just subscribe to the bk-commits-head mailing list, and then have
procmail set up a filter to alert you to anything that happens to files
in any specific directories.

Or do something else with the data sent on that mailing list, or look at
the changeset files on kernel.org that are constantly being generated.

There are lots of ways to get this information without relying on hooks
in bk.

Hope this helps,

greg k-h
