Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbRETLSu>; Sun, 20 May 2001 07:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbRETLSj>; Sun, 20 May 2001 07:18:39 -0400
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:51981 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S261795AbRETLSf>; Sun, 20 May 2001 07:18:35 -0400
Date: Sun, 20 May 2001 12:18:06 +0100 (BST)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
To: <Andries.Brouwer@cwi.nl>
cc: <viro@math.psu.edu>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]
 device arguments from lookup)
In-Reply-To: <UTC200105191641.SAA53411.aeb@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.30.0105201214450.22933-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 May 2001 Andries.Brouwer@cwi.nl wrote:

> One would like to have a version of the open() call that was
> guaranteed free of side effects, and gave a fd only -
> perhaps for stat(), perhaps for ioctl().

I did this a while ago, after some discussion.  The
implementation may suck, but I think it's a useful
facility.

http://web.gnu.walfield.org/mail-archive/linux-fsdevel/2000-March/0230.html

Matthew.

