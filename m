Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbTJGMid (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 08:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbTJGMid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 08:38:33 -0400
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:64009 "EHLO
	ford.pronto.tv") by vger.kernel.org with ESMTP id S262285AbTJGMic
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 08:38:32 -0400
To: linux-kernel@vger.kernel.org
Subject: devfs vs. udev
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 07 Oct 2003 14:38:27 +0200
Message-ID: <yw1xad8dfcjg.fsf@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I noticed this in the help text for devfs in 2.6.0-test6:

	  Note that devfs has been obsoleted by udev,
	  <http://www.kernel.org/pub/linux/utils/kernel/hotplug/>.
	  It has been stripped down to a bare minimum and is only provided for
	  legacy installations that use its naming scheme which is
	  unfortunately different from the names normal Linux installations
	  use.

Now, this puzzles me, for a few of reasons.  Firstly, not long ago,
devfs was spoken of as the way to go, and all drivers were rewritten
to support it.  Why this sudden change?  Secondly, that link only
leads me to a package describing itself as an experimental
proof-of-concept thing, not to be used for anything serious.  How can
something that incomplete obsolete a working system like devfs?
Thirdly, udev appears to respond to hotplug events only.  How is it
supposed to handle device files not corresponding to any physical
device?  Finally, I quite liked the idea of a virtual filesystem for
/dev.  It reduced the clutter quite a bit.  As for the naming scheme,
it could easily be changed.


-- 
Måns Rullgård
mru@users.sf.net
