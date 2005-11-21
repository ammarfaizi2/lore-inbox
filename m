Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbVKUKLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVKUKLe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 05:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbVKUKLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 05:11:34 -0500
Received: from ns.firmix.at ([62.141.48.66]:58245 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S932251AbVKUKLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 05:11:34 -0500
Subject: Re: Sun's ZFS and Linux
From: Bernd Petrovitsch <bernd@firmix.at>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Tarkan Erimer <tarkane@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051119172337.GA24765@thunk.org>
References: <9611fa230511181538g3e8ec403uafa9ed32b560fb0c@mail.gmail.com>
	 <20051119172337.GA24765@thunk.org>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 21 Nov 2005 11:11:21 +0100
Message-Id: <1132567881.22529.42.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-19 at 12:23 -0500, Theodore Ts'o wrote:
> On Fri, Nov 18, 2005 at 11:38:16PM +0000, Tarkan Erimer wrote:
> > 
> > On Nov.16, Sun has open sourced the
> > (http://www.opensolaris.org/os/announcements/#2005-11-16_welcome_to_the_zfs_community_
> > ) ZFS. I know that, It is licensed under CDDL. So, It is not GPL
> > compatible. In this situation, there is no way for Linux mainline. But
> > I wonder, is there anybody has a plan to port ZFS for Linux as a
> > separate patch ?
> 
> That wouldn't be a "port", it would have to be a complete
> reimplementation from scratch.  And, of course, of further concern
> would be whether or not there are any patents that Sun may have filed
> covering ZFS.  If the patents have only been licensed for CDDL
> licensed code, then that won't help a GPL'ed covered reimplementation.

Hmm, one could thake the zfs as a blurb and write a GPL'ed adapter (as
external patch) to the Kernel (similar to the nvidia ones and their
binary blurb drivers). The ZFS blurb would count as "not derived" since
it is IMHO exactly that.
And now I don't know if it makes sense, could actually work or how much
work it is. Experienced VFS people may have a opinion on this.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

