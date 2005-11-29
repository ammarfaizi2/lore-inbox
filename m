Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbVK2OnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbVK2OnD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 09:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbVK2OnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 09:43:03 -0500
Received: from mtao02.charter.net ([209.225.8.187]:19191 "EHLO
	mtao02.charter.net") by vger.kernel.org with ESMTP id S1751358AbVK2OnC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 09:43:02 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAQAAA+k=
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17292.26865.399015.693010@smtp.charter.net>
Date: Tue, 29 Nov 2005 09:42:57 -0500
From: "John Stoffel" <john@stoffel.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Lars Marowsky-Bree <lmb@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
In-Reply-To: <20051129055749.GT11266@alpha.home.local>
References: <11b141710511210144h666d2edfi@mail.gmail.com>
	<20051121095915.83230.qmail@web36406.mail.mud.yahoo.com>
	<20051121101959.GB13927@wohnheim.fh-wedel.de>
	<20051128125351.GE30589@marowsky-bree.de>
	<20051129050439.GB22879@thunk.org>
	<20051129055749.GT11266@alpha.home.local>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Willy" == Willy Tarreau <willy@w.ods.org> writes:

Willy> Having played a few months with a machine installed with advfs,
Willy> I can say that I *loved* this FS. It could be hot-resized,
Willy> mounted into several places at once (a bit like we can do now
Willy> with --bind), and best of all, it was by far the fastest FS I
Willy> had ever seen. I think that the 512 MB cache for the metadata
Willy> helped a lot ;-)

It was a wonderful FS, but if you used a PrestoServer NFS accelerator
board on the system with 4mb of RAM, but forgot to actually enable the
battery, bad things happened when the system crashed... you got a nice
4mb hole in the filesystem which caused wonderfully obtuse panics.
All the while the hardware keeps insisting that the battery on the
NVRAM board was just fine... turned out to be a hardware bug on the
NVRAM board, which screwed us completely.

Once that was solved, back in Oct 93 time frame as I recall, the Advfs
filesystem just ran and ran and ran.  Too bad DEC/Compaq/HP won't
release it nowdays....

John
