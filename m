Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUISRnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUISRnr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 13:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUISRnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 13:43:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:33256 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261426AbUISRnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 13:43:42 -0400
Date: Sun, 19 Sep 2004 10:32:21 -0700
From: Greg KH <greg@kroah.com>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
Message-ID: <20040919173221.GB2345@kroah.com>
References: <414C9003.9070707@softhome.net> <1095568704.6545.17.camel@gaston> <414D42F6.5010609@softhome.net> <cijrui$g9s$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cijrui$g9s$1@sea.gmane.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2004 at 05:53:05PM +0600, Alexander E. Patrakov wrote:
> 
> What we currently see is that distros either ignore the race or (like 
> LFS) say something like:

I don't see distros ignoring the race issues.  Look at Gentoo's init
scripts, it handles this properly (if not, please let me know.)

> "Because of all those compilcations with Hotplug, Udev and modules, we 
> strongly recommend you to start with a completely non-modular kernel 
> configuration, especially if this is the first time you use Udev."

Heh, no, you'll have the same "issues" with a static kernel and no
modules.  Your devices will not get found any faster :)

thanks,

greg k-h
