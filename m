Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273616AbRIQOC6>; Mon, 17 Sep 2001 10:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273617AbRIQOCs>; Mon, 17 Sep 2001 10:02:48 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:24006 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S273616AbRIQOCl>; Mon, 17 Sep 2001 10:02:41 -0400
Date: Mon, 17 Sep 2001 15:03:05 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: Jan Kara <jack@suse.cz>
cc: <linux-kernel@vger.kernel.org>, <bertie@scn.org>
Subject: Re: 2.4, 2.4-ac and quotas
In-Reply-To: <20010917152855.B18298@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33.0109171441550.20292-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 15:28 +0200 Jan Kara wrote:

>  And are you sure that /export01/aquota.user is correct quotafile (ie.
>created by quotacheck or convertquota)? This is message you usually get
>when quotafile has incorrect header... (or also when bogus arguments
>are specified but it's probably not your case).

Bingo.. I naively read http://www.linuxdoc.org/HOWTO/mini/Quota.html
and applied it to vfsv0. Could this be updated to reflect the new quotas
please? I'd like to read of the differences--is, for example, the new
quotacheck faster? Or does it all depend on the speed of the underlying
filesystem ond not much else?

Thanks,

Matt

