Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268253AbUH3ScV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268253AbUH3ScV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 14:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268210AbUH3SbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 14:31:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64192 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268724AbUH3S3a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 14:29:30 -0400
Date: Mon, 30 Aug 2004 19:29:29 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: John Cherry <cherry@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 47 New compile/sparse warnings (over the weekend)
Message-ID: <20040830182929.GK16297@parcelfarce.linux.theplanet.co.uk>
References: <1093887916.2653.10.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093887916.2653.10.camel@cherrybomb.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 10:45:16AM -0700, John Cherry wrote:
> drivers/scsi/megaraid/...
<tons>

Would it be too much to ask people run make C=1 before submitting?

[snip]

> sound/usb/usx2y/usX2Yhwdep.c:218:6: warning: incorrect type in

... piece of shit code.  Already fixed in a patch submitted to Linus.
And no, lack of annotations was not the worst part of it.
