Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265662AbTFXEIY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 00:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265664AbTFXEIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 00:08:24 -0400
Received: from almesberger.net ([63.105.73.239]:10501 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S265662AbTFXEIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 00:08:21 -0400
Date: Tue, 24 Jun 2003 01:22:20 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel & BIOS return differing head/sector geometries
Message-ID: <20030624012220.E1418@almesberger.net>
References: <20030624010906.08ad32f3.ktech@wanadoo.es> <20030624013908.B1133@pclin040.win.tue.nl> <bd8hgj$cas$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd8hgj$cas$1@cesium.transmeta.com>; from hpa@zytor.com on Mon, Jun 23, 2003 at 08:45:23PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Actually, unless you have it "linear" or "lba32", LILO *does* use
> CHS.  Unfortunately.

Distribution makers shouldn't be overly impressed by this default,
and just put "lba32" into any new lilo.conf they generate, or at
least offer the option to do so.

Keeping the old CHS default makes sure that people upgrading LILO
on an already configured (and probably quite ancient) system that
really needs CHS don't get a nasty surprise.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
