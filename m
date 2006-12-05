Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968484AbWLERUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968484AbWLERUp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 12:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968485AbWLERUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 12:20:45 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:39209 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968484AbWLERUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 12:20:44 -0500
Message-Id: <200612051720.kB5HKU4i001616@dell2.home>
To: linux-kernel@vger.kernel.org, bug-cpio@gnu.org
cc: martin.leisner@xerox.com
Subject: ownership/permissions of cpio initrd
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1613.1165339230.1@dell2.home>
Date: Tue, 05 Dec 2006 12:20:30 -0500
From: "Marty Leisner" <linux@rochester.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on an embedded system with the 2.6 kernel -- cpio
initrd was a new feature I'm looking at (and very welcome).

The major advantage I see is you don't have MAKE a filesystem
on the build host (doing cross development).  So you don't have
to be root.

But its "useful" to change permissions/ownership of the initrd
files at times...

Since a cpio is just a userspace created string of bits, I suppose
you can apply a set of ownership/permissions to files IN the archive
by playing with the bits...

Does such a tool exist?  Comments?  Seems very useful in order to
avoid being root...

marty
