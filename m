Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317517AbSGXUCR>; Wed, 24 Jul 2002 16:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317552AbSGXUCF>; Wed, 24 Jul 2002 16:02:05 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:40967 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317517AbSGXUAx>;
	Wed, 24 Jul 2002 16:00:53 -0400
Date: Wed, 24 Jul 2002 13:03:52 -0700
From: Greg KH <greg@kroah.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Build Errors] kernel version 2.5.27
Message-ID: <20020724200352.GE11384@kroah.com>
References: <20020723091438.GB3455@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020723091438.GB3455@localhost>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 26 Jun 2002 18:46:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 11:14:38AM +0200, Jose Luis Domingo Lopez wrote:
> ERROR #4
> pci_hotplug_core.c: In function `default_read_file':

<snip>

Known problem, happened when someone tried to "fix" the debug macros in
that file.  I just sent Linus the change for this.

thanks,

greg k-h
