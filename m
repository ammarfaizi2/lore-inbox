Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932822AbVJ3ETS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932822AbVJ3ETS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 00:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932825AbVJ3ETS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 00:19:18 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:29589 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932822AbVJ3ETS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 00:19:18 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] toshiba_ohci1394_dmi_table should be __devinitdata, not __devinit
Date: Sat, 29 Oct 2005 21:19:13 -0700
User-Agent: KMail/1.8.2
Cc: Roland Dreier <rolandd@cisco.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <52fyqlorj8.fsf@cisco.com> <200510290744.00642.jbarnes@virtuousgeek.org> <20051029195749.GB14978@suse.de>
In-Reply-To: <20051029195749.GB14978@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510292119.13959.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, October 29, 2005 12:57 pm, Greg KH wrote:
> > Oops, yeah I think this is correct.  We should also mark
> > toshiba_line_size as __devinitdata.  Patch relative to yours.
>
> Why?  Is it really worth it?  2 bytes?  Ick.

More for consistency than anything else.  No biggie.

> It's time to just make CONFIG_HOTPLUG always on to keep messes like
> this from happening...

Fine with me!

Jesse
