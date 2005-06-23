Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262581AbVFWII6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbVFWII6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbVFWIGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:06:43 -0400
Received: from nome.ca ([65.61.200.81]:4544 "HELO gobo.nome.ca")
	by vger.kernel.org with SMTP id S262507AbVFWGfH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:35:07 -0400
Date: Wed, 22 Jun 2005 23:34:57 -0700
From: Mike Bell <kernel@mikebell.org>
To: Miles Bader <miles@gnu.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Message-ID: <20050623063457.GB955@mikebell.org>
Mail-Followup-To: Mike Bell <kernel@mikebell.org>,
	Miles Bader <miles@gnu.org>, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20050621062926.GB15062@kroah.com> <20050620235403.45bf9613.akpm@osdl.org> <20050621151019.GA19666@kroah.com> <20050623010031.GB17453@mikebell.org> <20050623045959.GB10386@kroah.com> <buoaclhwqfj.fsf@mctpc71.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buoaclhwqfj.fsf@mctpc71.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 03:14:08PM +0900, Miles Bader wrote:
> BTW, has anyone done a comparison of the space usage of udev vs. devfs
> (including size of code etc....)?

Greg gave me an "I assume so" estimate that udev was smaller by excluding
the size of sysfs a while back. If you include sysfs in udev's overhead
then I believe devfs wins handily, but I haven't done the numbers to
prove it so my estimate is no better. I'm just basing it on sysfs being
absolutely huge, in linux-tiny terms.
