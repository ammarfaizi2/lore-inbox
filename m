Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267096AbTGTNJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 09:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267123AbTGTNJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 09:09:56 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:30593 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S267096AbTGTNJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 09:09:55 -0400
Date: Sun, 20 Jul 2003 14:34:28 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307201334.h6KDYSqC002010@81-2-122-30.bradfords.org.uk>
To: linux-kernel@vger.kernel.org, pavel@ucw.cz, torvalds@osdl.org
Subject: Re: Separate ACPI_SLEEP and SOFTWARE_SUSPEND options
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  	  Right now you may boot without resuming and then later resume but
>  	  in meantime you cannot use those swap partitions/files which were
>  	  involved in suspending. Also in this case there is a risk that buffers
>  	  on disk won't match with saved ones.

What happens on a machine which is sharing swap space between two
operating systems?  Do we have a way to mark a swap partition which is
used for suspend data as unusable?  Maybe we could change the
partition type from 82 to something else.

John.
