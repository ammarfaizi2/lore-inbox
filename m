Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265621AbUAPUx2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 15:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265699AbUAPUx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 15:53:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6588 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265621AbUAPUw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 15:52:56 -0500
Date: Fri, 16 Jan 2004 15:52:36 -0500
From: Alan Cox <alan@redhat.com>
To: John Bradford <john@grabjohn.com>
Cc: Jonathan Kamens <jik@kamens.brookline.ma.us>, linux-kernel@vger.kernel.org,
       alan@redhat.com
Subject: Re: Updated on UDMA BadCRC errors + subsequent problems (was: Is it safe to ignore UDMA BadCRC errors?)
Message-ID: <20040116205236.GI9648@devserv.devel.redhat.com>
References: <16368.20794.147453.255239@jik.kamens.brookline.ma.us> <16389.63781.783923.930112@jik.kamens.brookline.ma.us> <16391.24288.194579.471295@jik.kamens.brookline.ma.us> <200401160747.i0G7ln1I000368@81-2-122-30.bradfords.org.uk> <16392.734.505550.6731@jik.kamens.brookline.ma.us> <200401161546.i0GFkkpa002053@81-2-122-30.bradfords.org.uk> <16392.2027.90408.850335@jik.kamens.brookline.ma.us> <200401161648.i0GGmYlJ002181@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401161648.i0GGmYlJ002181@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 04:48:34PM +0000, John Bradford wrote:
> I _think_ that UDMA CRC checking is only done on data transfers, not
> commands.  I've CC'ed Alan in the hope of getting some confirmation on
> this.  Maybe a command being corrupted on the wire could theoretically
> cause that error.

You are correct for PATA but the situation there is very very unlikely,
let alone for it to be repeatable

