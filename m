Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVEJRY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVEJRY7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 13:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVEJRY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 13:24:59 -0400
Received: from attila.bofh.it ([213.92.8.2]:20947 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S261708AbVEJRY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 13:24:58 -0400
Date: Tue, 10 May 2005 19:24:47 +0200
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Greg KH <gregkh@suse.de>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050510172447.GA11263@wonderland.linux.it>
Mail-Followup-To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
	Rusty Russell <rusty@rustcorp.com.au>, Greg KH <gregkh@suse.de>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20050506212227.GA24066@kroah.com> <1115611034.14447.11.camel@localhost.localdomain> <20050509232103.GA24238@suse.de> <1115717357.10222.1.camel@localhost.localdomain> <20050510094339.GC6346@wonderland.linux.it> <4280AFF4.6080108@ums.usu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4280AFF4.6080108@ums.usu.ru>
User-Agent: Mutt/1.5.9i
From: md@Linux.IT (Marco d'Itri)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 10, "Alexander E. Patrakov" <patrakov@ums.usu.ru> wrote:

> Why not this or something similar (e.g. I want to blacklist the xxx and 
> yyy modules)? (note, untested)
Because it's impossible to predict how it will interact with other
install and alias commands.

A less fundamental but still major problem is that this would be a
different API, and both users and packages have been aware of
/etc/hotplug/blacklist* for a long time now.

-- 
ciao,
Marco
