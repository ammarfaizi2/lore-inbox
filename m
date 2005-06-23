Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262633AbVFWIMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbVFWIMh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbVFWIL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:11:29 -0400
Received: from nome.ca ([65.61.200.81]:49857 "HELO gobo.nome.ca")
	by vger.kernel.org with SMTP id S262128AbVFWGrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:47:20 -0400
Date: Wed, 22 Jun 2005 23:47:06 -0700
From: Mike Bell <kernel@mikebell.org>
To: Andrew Morton <akpm@osdl.org>
Cc: miles@gnu.org, greg@kroah.com, gregkh@suse.de, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Message-ID: <20050623064705.GC955@mikebell.org>
Mail-Followup-To: Mike Bell <kernel@mikebell.org>,
	Andrew Morton <akpm@osdl.org>, miles@gnu.org, greg@kroah.com,
	gregkh@suse.de, torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20050621062926.GB15062@kroah.com> <20050620235403.45bf9613.akpm@osdl.org> <20050621151019.GA19666@kroah.com> <20050623010031.GB17453@mikebell.org> <20050623045959.GB10386@kroah.com> <buoaclhwqfj.fsf@mctpc71.ucom.lsi.nec.co.jp> <20050623063457.GB955@mikebell.org> <20050622233759.7a1130a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050622233759.7a1130a9.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 11:37:59PM -0700, Andrew Morton wrote:
> sysfs certainly has a history of goggling gobs of memory.  But you can
> disable it in .config.

Right. Which breaks udev. Hence I say that if you're looking at "size of
devfs versus udev for solution X" and your devfs solution doesn't require
sysfs, then sysfs should be included in the size of udev for the sake of
the comparison.

Before anyone asks, that's not to say that sysfs is useless in a devfs
setting, merely that it's not required in most whereas it is required
for udev to even work.
