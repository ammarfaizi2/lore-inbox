Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbULKC2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbULKC2J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 21:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbULKC2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 21:28:08 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:56837 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261912AbULKC2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 21:28:02 -0500
To: Greg KH <greg@kroah.com>
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <20041210005055.GA17822@kroah.com>
	<200412101729.01155.david-b@pacbell.net>
	<20041211013930.GB12846@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 10 Dec 2004 18:26:49 -0800
In-Reply-To: <20041211013930.GB12846@kroah.com> (Greg KH's message of "Fri,
 10 Dec 2004 17:39:30 -0800")
Message-ID: <52is797eom.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [linux-usb-devel] [RFC PATCH] debugfs - yet another in-kernel
 file system
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 11 Dec 2004 02:26:49.0974 (UTC) FILETIME=[DE9D1960:01C4DF28]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> I considered adding a kobject as a paramater to the debugfs
    Greg> interface.  The file created would be equal to the path that
    Greg> the kobject has.  Would that work for you?

I'd really prefer this to be optional at least.  Somethings it's nice
to use kobjects for, but creating hierarchies of subdirectories is not
really one of them.

 - R.
