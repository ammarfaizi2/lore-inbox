Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265113AbUASOyh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 09:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265139AbUASOyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 09:54:37 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:58360 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S265113AbUASOyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 09:54:35 -0500
Date: Mon, 19 Jan 2004 06:54:30 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Oliver Kiddle <okiddle@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page allocation failure
Message-ID: <20040119145430.GI1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Oliver Kiddle <okiddle@yahoo.co.uk>,
	linux-kernel@vger.kernel.org
References: <7641.1074512162@gmcs3.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7641.1074512162@gmcs3.local>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 12:36:02PM +0100, Oliver Kiddle wrote:
> If anyone can suggest any /proc variables I might change to reduce the
> risk of it doing this again, I would appreciate it. I tried increasing
> /proc/sys/vm/min_free_kbytes after the first time this happened. Not
> that I understand what that does: I searched the archives and it was
> mentioned in a vaguely relevant looking post.

Try running "vmstat 1" and output that to a file, and post your /proc/meminfo.

Do you start getting the error before a couple of days, or you just can't
login after that amount of time?
