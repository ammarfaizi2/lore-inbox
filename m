Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbTJMKZM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 06:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbTJMKZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 06:25:12 -0400
Received: from smtp1.att.ne.jp ([165.76.15.137]:12469 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S261659AbTJMKZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 06:25:09 -0400
Message-ID: <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "John Bradford" <john@grabjohn.com>, <linux-kernel@vger.kernel.org>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk>
Subject: Re: Why are bad disk sectors numbered strangely, and what happens to them?
Date: Mon, 13 Oct 2003 19:24:00 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford replied to me:

> > How can I tell Linux to read every sector in the partition?  Oh, I might
> > know this one,
> >   dd if=/dev/hda8 of=/dev/null
> > I want to make sure that the drive is now using a non-defective
> > replacement sector.
>
> A read won't necessarily do that.  You might have to write to a
> defective sector to force re-allocation.

I agree, we are not sure if a read will do that.  That is the reason why two
of my preceding questions were:

   How can I find out which file contains the bad sector?  I would like to
   try to recreate the file from a source of good data.

   How can I tell Linux to mark the sector as bad, knowing the LBA sector
   number?

And that is also the reason why my last question, which Mr. Bradford replied
to, had the stated purpose of making sure that the drive is now using a
non-defective replacement sector after the preceding operations have been
carried out.

Please, the important questions are important.  Doesn't anyone really know
what Linux does with bad blocks, how to find out which file contains them,
how to get Linux to force them to be marked and reallocated?

