Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbTJNV0m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 17:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262937AbTJNV0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 17:26:41 -0400
Received: from mail.kroah.org ([65.200.24.183]:35804 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262932AbTJNV0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 17:26:40 -0400
Date: Tue, 14 Oct 2003 14:23:36 -0700
From: Greg KH <greg@kroah.com>
To: sting sting <qwejohn@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: from where are the devlabel  messages in /var/log/message
Message-ID: <20031014212336.GC17310@kroah.com>
References: <BAY1-F48dp9oPEtxB230000f33a@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY1-F48dp9oPEtxB230000f33a@hotmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 04:35:13PM +0200, sting sting wrote:
> 
> what is the  kermel origin of these devlabel  messages ?

There is no kernel orgin of these messages.  The devlabel program is
being run from the hotplug scripts, which run when a device is plugged
in or removed from the system.  All in userspace.

Hope this helps,

greg k-h
