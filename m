Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbTHYEDv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 00:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbTHYEDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 00:03:51 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:24781 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261363AbTHYEDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 00:03:50 -0400
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: John Bradford <john@grabjohn.com>, hch@lst.de, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix the -test3 input config damages
References: <200308221757.h7MHv3uS000585@81-2-122-30.bradfords.org.uk>
	<20030822180030.GI1040@matchmail.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 25 Aug 2003 13:03:24 +0900
In-Reply-To: <20030822180030.GI1040@matchmail.com>
Message-ID: <buo3cfqidtf.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> writes:
> I think I like CONFIG_NONSTD_ABI better.

ABIs are typically thought of as being CPU/platform-specific, so this
seems wrong -- an embedded platform may in fact standardize on never
having `big unix' features X, Y, & Z.

-Miles
-- 
Would you like fries with that?
