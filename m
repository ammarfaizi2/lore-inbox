Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbUKPR7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbUKPR7e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 12:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUKPR7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 12:59:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:33693 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262076AbUKPR7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 12:59:30 -0500
Date: Tue, 16 Nov 2004 09:58:57 -0800
From: Greg KH <greg@kroah.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: rcpt-linux-fsdevel.AT.vger.kernel.org@jankratochvil.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041116175857.GA9213@kroah.com>
References: <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org> <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu> <84144f0204111602136a9bbded@mail.gmail.com> <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu> <20041116120226.A27354@pauline.vellum.cz> <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu> <20041116163314.GA6264@kroah.com> <E1CU6SL-0007FP-00@dorka.pomaz.szeredi.hu> <20041116170339.GD6264@kroah.com> <E1CU7Tg-0007O8-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CU7Tg-0007O8-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 06:50:52PM +0100, Miklos Szeredi wrote:
> 
> > It's an old message, and yes, it's there to scare people away.  Glad to
> > see it's working :)
> 
> So if I only need a single device number should I register a "misc"
> device?  misc_register() seems to create the relevant sysfs entry.

Yes, that is a good way to get a device, without having to reserve a
number.

thanks,

greg k-h
