Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272072AbTGYNnj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 09:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272073AbTGYNnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 09:43:39 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:5535 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S272072AbTGYNni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 09:43:38 -0400
Date: Fri, 25 Jul 2003 09:47:55 -0400
From: Ben Collins <bcollins@debian.org>
To: gaxt <gaxt@rogers.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
Message-ID: <20030725134755.GC1512@phunnypharm.org>
References: <20030724223615.GN1512@phunnypharm.org> <20030724230928.GB23196@ruvolo.net> <1059095616.1897.34.camel@torrey.et.myrio.com> <20030725012723.GF23196@ruvolo.net> <20030725012908.GT1512@phunnypharm.org> <1059103424.24427.108.camel@daedalus.samhome.net> <20030725041234.GX1512@phunnypharm.org> <20030725053920.GH23196@ruvolo.net> <20030725133438.GZ1512@phunnypharm.org> <3F213961.3090501@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F213961.3090501@rogers.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> root@localhost linux # cat firewire2 | patch -p1
> missing header for unified diff at line 5 of patch
> can't find file to patch at input line 5
> Perhaps you used the wrong -p or --strip option?
> The text leading up to this was:
> --------------------------
> |Index: ieee1394_core.c
> |===================================================================
> |--- ieee1394_core.c    (revision 1013)
> |+++ ieee1394_core.c    (working copy)
> --------------------------
> File to patch:
> root@localhost linux #

My mistake for not doing a full path diff. Do this:

patch drivers/ieee1394/ieee1394_core.c < firewire2

> Also, how do I compiled the modules with debug enabled? Thanks.

There's a config option under IEEE1394 for verbose debugging.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
