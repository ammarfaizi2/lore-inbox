Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269433AbUJLAcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269433AbUJLAcT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269419AbUJLAZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:25:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:24538 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269404AbUJLATj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:19:39 -0400
Date: Mon, 11 Oct 2004 17:19:01 -0700
From: Greg KH <greg@kroah.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Mdk-Cooker <cooker@linux-mandrake.com>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: udev: what's up with old /dev ?
Message-ID: <20041012001901.GA23831@kroah.com>
References: <1097446129l.5815l.0l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097446129l.5815l.0l@werewolf.able.es>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2004 at 10:08:49PM +0000, J.A. Magallon wrote:
> Hi all...
> 
> I have just remembered that udev mounts /dev as a tmpfs filesystem, _on top_
> of the old /dev directory.

Well, that's the way _your_ distro does it.  Mine has an empty /dev on
the root filesystem, and the init scripts create a ramfs on top of /dev
at boot time, which udev fills up.

thanks,

greg k-h
