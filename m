Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbUKWHk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbUKWHk5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 02:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbUKWHk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 02:40:57 -0500
Received: from mail.kroah.org ([69.55.234.183]:5858 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262313AbUKWHka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 02:40:30 -0500
Date: Mon, 22 Nov 2004 23:38:27 -0800
From: Greg KH <greg@kroah.com>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC/v1][11/12] Add InfiniBand Documentation files
Message-ID: <20041123073827.GA23122@kroah.com>
References: <20041122714.taTI3zcdWo5JfuMd@topspin.com> <20041122714.AyIOvRY195EGFTaO@topspin.com> <20041122225335.GE15634@kroah.com> <52sm71bie2.fsf@topspin.com> <20041122230533.GB13083@kroah.com> <20041122233047.GH27658@sventech.com> <20041123064508.GC22493@kroah.com> <20041123065110.GA3959@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123065110.GA3959@sventech.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 10:51:10PM -0800, Johannes Erdfelt wrote:
> 
> Is the eventual plan to move to dynamic majors for all devices?

No, some people will not allow that to happen, it would break too many
old programs and configurations.

It will probably be a config option if people wish to try it out (it's
only about a 3 line change to the kernel to enable this, I need to just
submit the patch one of these days...)

thanks,

greg k-h
