Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263451AbTJUWO5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 18:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTJUWO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 18:14:57 -0400
Received: from mail.kroah.org ([65.200.24.183]:7867 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263451AbTJUWO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 18:14:56 -0400
Date: Tue, 21 Oct 2003 15:13:38 -0700
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 004 release
Message-ID: <20031021221337.GA3083@kroah.com>
References: <20031021162856.GA1030@kroah.com> <20031021214554.GA7791@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031021214554.GA7791@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 02:45:55PM -0700, Jesse Barnes wrote:
> Thanks for the new release, Greg.  I just tried it out on a system with
> some disks, but a bunch of udev processes ended up hanging.  Is there
> something I'm missing or do you need a patch like this?

Yeah, sorry, this kind of fix is required :(

It's fixed in my bk tree now.

Oh, and it looks like the LABEL rule is also broken due to the libsysfs
changes...  I'm working on adding regression tests right now to prevent
things like this from slipping through.

thanks,

greg k-h
