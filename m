Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbULQQgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbULQQgc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 11:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbULQQgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 11:36:32 -0500
Received: from mail1.kontent.de ([81.88.34.36]:48843 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261831AbULQQbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 11:31:11 -0500
From: Oliver Neukum <oliver@neukum.org>
To: linux-os@analogic.com
Subject: Re: [Coverity] Untrusted user data in kernel
Date: Fri, 17 Dec 2004 17:31:05 +0100
User-Agent: KMail/1.6.2
Cc: Bill Davidsen <davidsen@tmr.com>, James Morris <jmorris@redhat.com>,
       Patrick McHardy <kaber@trash.net>, Bryan Fulton <bryan@coverity.com>,
       netdev@oss.sgi.com, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
References: <41C26DD1.7070006@trash.net> <41C2FF99.3020908@tmr.com> <Pine.LNX.4.61.0412171108340.4216@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0412171108340.4216@chaos.analogic.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200412171731.05735.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Are you saying that processes with capability don't make mistakes? This isn't 
> > a bug related to untrusted users doing privileged operations, it's a case of 
> > using unchecked user data.
> >
> 
> But isn't there always the possibility of "unchecked user data"?
> I can, as root, do `cp /dev/zero /dev/mem` and have the most
> spectacular crask you've evet seen. I can even make my file-
> systems unrecoverable.

Only if you have the capability for raw hardware access.
The same is true for the firmware interface. What other subsystems might
be dangerous?

	Regards
		Oliver
