Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265169AbSJaDaT>; Wed, 30 Oct 2002 22:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265166AbSJaD3N>; Wed, 30 Oct 2002 22:29:13 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:2577 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265169AbSJaD2Y>;
	Wed, 30 Oct 2002 22:28:24 -0500
Date: Wed, 30 Oct 2002 19:31:55 -0800
From: Greg KH <greg@kroah.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.45
Message-ID: <20021031033155.GA5602@kroah.com>
References: <Pine.LNX.4.44.0210301651120.6719-100000@penguin.transmeta.com> <3396299720.1036004191@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3396299720.1036004191@[10.10.2.3]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 06:56:32PM -0800, Martin J. Bligh wrote:
> Just some warnings, if anyone's bored, and wants something to fix ;-)
> 
> drivers/base/base.h:64: warning: `class_hotplug' defined but not used
> drivers/base/base.h:64: warning: `class_hotplug' defined but not used
> drivers/base/base.h:64: warning: `class_hotplug' defined but not used
> drivers/base/base.h:64: warning: `class_hotplug' defined but not used
> drivers/base/base.h:64: warning: `class_hotplug' defined but not used

Why would you want to run a kernel with CONFIG_HOTPLUG turned off!

Grumble, I forgot a "inline" in base.h, I'll fix it later...

greg k-h
