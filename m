Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263627AbTDTQnV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 12:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbTDTQnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 12:43:21 -0400
Received: from mail.ithnet.com ([217.64.64.8]:4625 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263627AbTDTQnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 12:43:20 -0400
Date: Sun, 20 Apr 2003 18:55:12 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: John Bradford <john@grabjohn.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Message-Id: <20030420185512.763df745.skraw@ithnet.com>
In-Reply-To: <200304201359.h3KDx0q5000260@81-2-122-30.bradfords.org.uk>
References: <20030419190046.6566ed18.skraw@ithnet.com>
	<200304201359.h3KDx0q5000260@81-2-122-30.bradfords.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Apr 2003 14:59:00 +0100 (BST)
John Bradford <john@grabjohn.com> wrote:

> > Ok, you mean active error-recovery on reading. My basic point is the
> > writing case. A simple handling of write-errors from the drivers level and
> > a retry to write on a different location could help a lot I guess.
> 
> A filesystem is not the place for that - it could either be done at a
> lower level, like I suggested in a separate post, or at a much higher
> level - E.G. a database which encounters a write error could dump it's
> entire contents to a tape drive, shuts down, and page an
> administrator, on the basis that the write error indicated impending
> drive failiure.

Can you tell me what is so particularly bad about the idea to cope a little bit
with braindead (or just-dying) hardware?
See, a car (to name a real good example) is not primarily built to have
accidents. Anyway everybody might agree that having a safety belt built into it
is a good idea, just to make the best out of a bad situation - even if it never
happens - , or not?

> Are you using the disks within their operational limits?  Are you sure
> they are not overheating and/or being run 24/7 when they are not
> intended to be?

No. The only thing we do is completely re-writing them once a day (data gets
exchanged). So our usage pattern is not: dump data on it and thats it (like
most of the people might do with big disks).

Regards,
Stephan

