Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbTJGOCF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 10:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbTJGOCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 10:02:05 -0400
Received: from adsl-68-248-192-57.dsl.klmzmi.ameritech.net ([68.248.192.57]:43015
	"EHLO mail.domedata.com") by vger.kernel.org with ESMTP
	id S262304AbTJGOCB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 10:02:01 -0400
From: tabris <tabris@tabris.net>
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns?=
	=?iso-8859-1?q?=20Rullg=E5rd?=)
Subject: Re: devfs vs. udev
Date: Tue, 7 Oct 2003 10:01:56 -0400
User-Agent: KMail/1.5.3
References: <yw1xad8dfcjg.fsf@users.sourceforge.net>
In-Reply-To: <yw1xad8dfcjg.fsf@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200310071001.56459.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 October 2003 08:38 am, Måns Rullgård wrote:
> I noticed this in the help text for devfs in 2.6.0-test6:
>
> 	  Note that devfs has been obsoleted by udev,
> 	  <http://www.kernel.org/pub/linux/utils/kernel/hotplug/>.
> 	  It has been stripped down to a bare minimum and is only provided for
> 	  legacy installations that use its naming scheme which is
> 	  unfortunately different from the names normal Linux installations
> 	  use.
>
> Now, this puzzles me, for a few of reasons.  Firstly, not long ago,
> devfs was spoken of as the way to go, and all drivers were rewritten
> to support it.  Why this sudden change?  Secondly, that link only
> leads me to a package describing itself as an experimental
> proof-of-concept thing, not to be used for anything serious.  How can
> something that incomplete obsolete a working system like devfs?
> Thirdly, udev appears to respond to hotplug events only.  How is it
> supposed to handle device files not corresponding to any physical
> device?  Finally, I quite liked the idea of a virtual filesystem for
> /dev.  It reduced the clutter quite a bit.  As for the naming scheme,
> it could easily be changed.
My word is hardly authoritative, but istr hearing that the original 
devfs-maintainer has abandoned this code (probably after multiple 
complaints about it being badly implemented, full of bugs, locking 
issues/races, etc).

Not having used it with 2.6 yet, I don't know much about it's status in 
that tree.

So, although devfs may still work, and even be in a better condition than 
udev (at present); no longer maintained (and little intention of 
changing) may be considered equivalent to obsolete.
--
tabris
-
	Max told his friend that he'd just as soon not go hiking in the hills.
Said he, "I'm an anti-climb Max."
	[So is that punchline.]

