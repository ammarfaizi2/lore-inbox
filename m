Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262349AbUKWJLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbUKWJLc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 04:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbUKWJLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 04:11:32 -0500
Received: from pD9EAFE85.dip.t-dialin.net ([217.234.254.133]:45530 "EHLO
	porty.steinbergnet.net") by vger.kernel.org with ESMTP
	id S262349AbUKWJL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 04:11:27 -0500
From: Dirk Steinberg <dws@steinbergnet.net>
To: reiserfs-list@namesys.com
Subject: Re: file as a directory
Date: Tue, 23 Nov 2004 10:11:21 +0100
User-Agent: KMail/1.7.1
Cc: Hans Reiser <reiser@namesys.com>, Valdis.Kletnieks@vt.edu,
       Amit Gud <amitgud1@gmail.com>, linux-kernel@vger.kernel.org
References: <2c59f00304112205546349e88e@mail.gmail.com> <200411221759.iAMHx7QJ005491@turing-police.cc.vt.edu> <41A23566.6080903@namesys.com>
In-Reply-To: <41A23566.6080903@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411231011.21652.dws@steinbergnet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 November 2004 19:52, Hans Reiser wrote:
> Valdis.Kletnieks@vt.edu wrote:
> >(Hint - "file as directory" broke a number of programs that didn't
> >expect that a file *could* be a directory, when run on a reiser4
> >filesystem...)
>
> It broke extraordinarily few.

I know from personal experience that it *does* break Acrobat Reader,
which, unfortunately, is binary-only and also a programm that I 
use quite often. For me this means I cannot use reiser4 (as root fs anyway)
without metas disabled.

How about making metas a mount option? Right now disabling metas 
requires patching the source.

/Dirk Steinberg
