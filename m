Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030392AbWBHOVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbWBHOVn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 09:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbWBHOVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 09:21:43 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5519 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030392AbWBHOVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 09:21:42 -0500
Subject: Re: [RFC] EXPORT_SYMBOL_GPL_FUTURE()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060208062007.GA7936@kroah.com>
References: <20060208062007.GA7936@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Feb 2006 14:23:49 +0000
Message-Id: <1139408629.26270.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-02-07 at 22:20 -0800, Greg KH wrote:
> Currently we don't have a way to show people that some kernel symbols
> will be changed in the future from EXPORT_SYMBOL() to
> EXPORT_SYMBOL_GPL(). 

For a good reason. When Linus first accepted the _GPL changes he did so
on the clear understanding that people wouldn't go around "privatising" 
existing symbols.

