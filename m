Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTLVSlK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 13:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263751AbTLVSlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 13:41:10 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:39297 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S263587AbTLVSlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 13:41:08 -0500
Date: Mon, 22 Dec 2003 10:40:31 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andreas Unterkircher <unki@netshadow.at>
Cc: Rob Love <rml@ximian.com>, linux-kernel@vger.kernel.org
Subject: Re: /proc/meminfo values
Message-ID: <20031222184031.GO6438@matchmail.com>
Mail-Followup-To: Andreas Unterkircher <unki@netshadow.at>,
	Rob Love <rml@ximian.com>, linux-kernel@vger.kernel.org
References: <1072104601.1165.33.camel@winsucks> <1072107066.3318.17.camel@fur> <1072107278.1165.36.camel@winsucks>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072107278.1165.36.camel@winsucks>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 04:34:38PM +0100, Andreas Unterkircher wrote:
> Ok, i'm unterstand :) I will simple multiply the proc values with 1024
> when i want to use them with the cricket-snmp-collector. this seems to
> be exactly enough - i only want to know - thanks rob and rik for the
> info!

You might want to check out the perl script I updated recently in the lrrd
project.  It tries to extract as much information from each kernel version
as possible that is presented in /proc/meminfo (and slabinfo for 2.4).

http://cvs.sourceforge.net/viewcvs.py/lrrd/lrrd/client/lrrd.d.linux/memory.in?sortby=date

Mike
