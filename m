Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbTDHIX0 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 04:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbTDHIX0 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 04:23:26 -0400
Received: from 237.oncolt.com ([213.86.99.237]:4033 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S261287AbTDHIXZ (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 04:23:25 -0400
Subject: Re: [ANNOUNCE] New kernel tree for embedded linux
From: David Woodhouse <dwmw2@infradead.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Andi Kleen <ak@suse.de>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030407194039.GF8178@wohnheim.fh-wedel.de>
References: <20030407171037.GB8178@wohnheim.fh-wedel.de.suse.lists.linux.kernel>
	 <p73r88exh3r.fsf@oldwotan.suse.de>
	 <20030407194039.GF8178@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=UTF-8
Organization: 
Message-Id: <1049790892.18045.120.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Tue, 08 Apr 2003 09:34:52 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-07 at 20:40, Jörn Engel wrote:
> Some more partitioning code that only applies to spinning discs of
> some sort (ide, scsi) or code that emulates spinning discs is always
> included. No config option.

We definitely want CONFIG_BLK_DEV. CONFIG_SWAP is a good start.

> Another one is serial.c. In an ltp test run, plus serial console, some
> 90% were unused. And the code gave me some shivers. Volunteers?

The new serial code is somewhat nicer. Still contains unconditional
support for a lot of bizarre 8250 variations, but I don't think that's
really taking up much space though.

-- 
dwmw2

