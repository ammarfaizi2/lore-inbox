Return-Path: <linux-kernel-owner+w=401wt.eu-S1754748AbWL0UmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbWL0UmX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 15:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754727AbWL0UmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 15:42:23 -0500
Received: from thunk.org ([69.25.196.29]:57165 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754748AbWL0UmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 15:42:22 -0500
Date: Wed, 27 Dec 2006 15:42:13 -0500
From: Theodore Tso <tytso@mit.edu>
To: Karel Zak <kzak@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
       Henne Vogelsang <hvogel@suse.de>, Olaf Hering <olh@suse.de>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: util-linux: orphan
Message-ID: <20061227204212.GA21393@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>, Karel Zak <kzak@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	Henne Vogelsang <hvogel@suse.de>, Olaf Hering <olh@suse.de>,
	"H. Peter Anvin" <hpa@zytor.com>
References: <20061109224157.GH4324@petra.dvoda.cz> <200612270346.10699.arnd@arndb.de> <20061227181510.GB17785@petra.dvoda.cz> <200612271939.48125.arnd@arndb.de> <20061227191824.GC17785@petra.dvoda.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061227191824.GC17785@petra.dvoda.cz>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2006 at 08:18:24PM +0100, Karel Zak wrote:
>  Frankly, it wasn't always easy to use SeLinux in previous FC
>  releases, but there is huge progress and I think it's much better in
>  FC6.

I've never tried SELinux, but at one point there were all sorts of
horror stories that if you enabled SELinux, the moment you installed
any 3rd party software packages, whether it's Oracle or Websphere or
some other commercial application program, the application would break
because of all sorts of SELinux policy violations, and that it
required an SELinux wizard to configure SELinux policy to enable a 3rd
party application to actually work correctly.  Given that I tried
enabling SELinux, witnessed things break spectacularly and with no
hints about how to fix things, I've always had the attitude of "life
is too short to enable SELinux", and so my limited experience is
consistent with all of the horror stories that I've heard.

It sounds like SELinux has gotten better, according to your
description.  Will handle arbitrary 3rd party software without running
wild, or is it still the case that the moment you want anything other
than software that was shipped with the distribution, it's "abandon
all hope, all ye who enter here"?

						- Ted


