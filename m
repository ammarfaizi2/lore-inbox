Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129861AbRBYFlq>; Sun, 25 Feb 2001 00:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129860AbRBYFlj>; Sun, 25 Feb 2001 00:41:39 -0500
Received: from www.wen-online.de ([212.223.88.39]:49170 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129861AbRBYFlW>;
	Sun, 25 Feb 2001 00:41:22 -0500
Date: Sun, 25 Feb 2001 06:41:21 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Bernd Eckenfels <W1012@lina.inka.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs: still problems with tail conversion
In-Reply-To: <E14WsgH-00006l-00@sites.inka.de>
Message-ID: <Pine.LNX.4.33.0102250638470.1656-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Feb 2001, Bernd Eckenfels wrote:

> In article <878610000.983061717@tiny> you wrote:
> > Exactly.  The tail conversion code depends heavily on the page up to date
> > bit being set right.  It is more than possible that I've screwed up
> > something there, and the code thinks a page is valid when it really isn't.
>
> I have seen null byte corruptions in syslog files with ext2 in various
> kernels. So perhaps it is a general VFS problem?

aol.. none since 2.4.0 release here though.

	-Mike

