Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266365AbUBLQH3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 11:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUBLQH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 11:07:29 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:9088 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266365AbUBLQH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 11:07:28 -0500
Date: Thu, 12 Feb 2004 16:17:17 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402121617.i1CGHH2c000275@81-2-122-30.bradfords.org.uk>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       Jamie Lokier <jamie@shareable.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200402121655.39709.robin.rosenberg.lists@dewire.com>
References: <20040209115852.GB877@schottelius.org>
 <20040212004532.GB29952@hexapodia.org>
 <20040212085451.GC20898@mail.shareable.org>
 <200402121655.39709.robin.rosenberg.lists@dewire.com>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Definitely a good reason.  It seem many assume file names are a local thing,
> but this is not so. Now consider the case with an external firewire
> disk or memory stick created on a machine with iso-8859-1 as the system character
> set and e.g xfs as the file system. What happens when I hook it up to a new redhat
> installation that thinks file names are best stored as utf8? Most non-ascii
> file names aren't even legal in utf8.

Another thing to consider is that you can encode the same character in
several ways using utf8, so two filenames could have different byte
strings, but evaluate to the same set of unicode characters.

John.
