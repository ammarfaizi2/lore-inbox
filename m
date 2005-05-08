Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262999AbVEHWwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262999AbVEHWwo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 18:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbVEHWwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 18:52:44 -0400
Received: from 1-1-2-5a.f.sth.bostream.se ([81.26.255.57]:10946 "EHLO
	1-1-2-5a.f.sth.bostream.se") by vger.kernel.org with ESMTP
	id S262999AbVEHWwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 18:52:43 -0400
Date: Mon, 9 May 2005 00:52:02 +0200 (CEST)
From: Per Liden <per@fukt.bth.se>
X-X-Sender: per@1-1-2-5a.f.sth.bostream.se
To: Greg KH <gregkh@suse.de>
cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
In-Reply-To: <20050506212227.GA24066@kroah.com>
Message-ID: <Pine.LNX.4.63.0505090025280.7682@1-1-2-5a.f.sth.bostream.se>
References: <20050506212227.GA24066@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 May 2005, Greg KH wrote:

[...]
> Now, with the 2.6.12-rc3 kernel, and a patch for module-init-tools, the
> USB hotplug program can be written with a simple one line shell script:
> 	modprobe $MODALIAS

Nice, but why not just convert all this to a call to 
request_module($MODALIAS)? Seems to me like the natural thing to do.

[...]
> Oh, and the upstream module-init-tools maintainer needs to accept that
> patch one of these days...

Where can this patch be found?

/Per
