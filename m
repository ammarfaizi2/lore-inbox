Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262621AbVAPWIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbVAPWIT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 17:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbVAPWIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 17:08:19 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:47660 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262621AbVAPWIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 17:08:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=bE6MQAaNR9BEtq+TO+XbNSq/6qTVcktxQ76ktPSbPTkiDWKgDOkyHGCpZaZmdFuYPdd28CAquj4o8mtjilA69hrWP8Dv4nSChWPUeIVN/f/Zu0x/PhRWoihQGfzpfUwGtmehynY9xdMaG6JLayglpnOi95XlqavbAFXNXvf7g4s=
Message-ID: <9e4733910501161408710bbbe2@mail.gmail.com>
Date: Sun, 16 Jan 2005 17:08:12 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: 2.6.10 dies when X tries to initialize PCI radeon 9200 SE
Cc: Dave Airlie <airlied@gmail.com>, covici@ccs.covici.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050116121823.GA7734@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41E64DAB.1010808@hist.no>
	 <16870.21720.866418.326325@ccs.covici.com>
	 <21d7e997050113130659da39c9@mail.gmail.com>
	 <20050115185712.GA17372@hh.idb.hist.no>
	 <21d7e997050116020859687c4a@mail.gmail.com>
	 <20050116105011.GA5882@hh.idb.hist.no>
	 <9e4733910501160304642f7882@mail.gmail.com>
	 <20050116121823.GA7734@hh.idb.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jan 2005 13:18:23 +0100, Helge Hafting
<helgehaf@aitel.hist.no> wrote:
> On Sun, Jan 16, 2005 at 06:04:32AM -0500, Jon Smirl wrote:
> > you need to check the output from "modprobe drm debug=1" "modprobe
> > radeon" and see if drm is misidentifying the board as AGP. We don't
> > want to fix something if it isn't broken.
> > 
> Stupid question - how do I get a modular drm?

For older radeon drivers "modprobe radeon debug=1" should work. I also
think you can do it for compiled in ones by adding the kernel
parameter radeon.debug=1

-- 
Jon Smirl
jonsmirl@gmail.com
