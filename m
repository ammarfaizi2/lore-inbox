Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVFNKbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVFNKbi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 06:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVFNKbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 06:31:38 -0400
Received: from mail4.worldserver.net ([217.13.200.24]:57477 "EHLO
	mail4.worldserver.net") by vger.kernel.org with ESMTP
	id S261168AbVFNKbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 06:31:36 -0400
Date: Tue, 14 Jun 2005 12:31:35 +0200
From: Christian Leber <christian@leber.de>
To: Frank Sorenson <frank@tuxrocks.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2/2] lzma support: lzma compressed kernel image
Message-ID: <20050614103135.GA4319@core.home>
References: <20050607214128.GB2645@core.home> <20050612223150.GA26370@core.home> <42AE3C91.4090904@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AE3C91.4090904@tuxrocks.com>
X-Accept-Language: de en
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 08:10:25PM -0600, Frank Sorenson wrote:

> patches appear to work as advertised.

I don't like the moving of the initrd, but i don't know another way to
get it working otherwise.

> lzma reduced my kernel by
> approximately 25%, so I'd say it looks promising.

25%? i would have expected a smaller saving

> I think one or more of the following ought to happen:
> - - Modify the help text in the Kconfig option to show people how to
> obtain, compile, and install lzma (and warn them they'll need to install
> it).

How to obtain should be enough, i'll add it.

> - - Detect that the lzma application isn't present, and fall back to gzip
> (with a warning) if lzma fails.

No.
If you select lzma you have to have it, you also don't download a
compiler when somebody tries to compile the kernel without a compiler.

> - - If we can embed the decompressor into the boot-time kernel, can't we
> put a compressor into the kernel source, and avoid the need for the
> external program?

How do think will people react to a hundreds of kb sized C++ patch that
is not - i repeat - NOT in proper coding style?


Christian Leber

-- 
http://www.nosoftwarepatents.com

