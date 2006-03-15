Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932596AbWCOFtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbWCOFtc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 00:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbWCOFtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 00:49:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:45024 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932596AbWCOFtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 00:49:31 -0500
Date: Tue, 14 Mar 2006 18:49:33 -0800
From: Greg KH <gregkh@suse.de>
To: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kobject_uevent CONFIG_SYSFS=n build fix
Message-ID: <20060315024933.GA10742@suse.de>
References: <4416EB14.50306@ce.jp.nec.com> <20060314220130.GB12257@suse.de> <44175911.1010400@ce.jp.nec.com> <20060315000951.GA6608@suse.de> <441767EB.6070908@ce.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441767EB.6070908@ce.jp.nec.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 08:03:39PM -0500, Jun'ichi Nomura wrote:
> Hi,
> 
> Greg KH wrote:
> >>@@ -27,6 +27,8 @@
> >>#include <asm/atomic.h>
> >>
> >>#define KOBJ_NAME_LEN			20
> >>+
> >>+#ifdef CONFIG_HOTPLUG
> >>#define UEVENT_HELPER_PATH_LEN		256
> 
> >That shouldn't be needed, right?
> 
> You're right. They are not needed.
> Please disregard that part.

Looks good.  Care to resend it one more time, this time with a good
changelog description and a Signed-off-by: line?

thanks,

greg k-h
