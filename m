Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270686AbTHEVGx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 17:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270688AbTHEVGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 17:06:52 -0400
Received: from mail.kroah.org ([65.200.24.183]:36552 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270686AbTHEVGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 17:06:52 -0400
Date: Tue, 5 Aug 2003 14:07:04 -0700
From: Greg KH <greg@kroah.com>
To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Cc: Sergey Vlasov <vsu@altlinux.ru>,
       "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Subject: Re: PATCH: 2.4.22-pre7 drivers/i2c/i2c-dev.c user/kernel bug and mem leak
Message-ID: <20030805210704.GA5452@kroah.com>
References: <20030803192312.68762d3c.khali@linux-fr.org> <20030804193212.11786d06.vsu@altlinux.ru> <20030805103240.02221bed.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805103240.02221bed.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 10:32:40AM +0200, Jean Delvare wrote:
> 
> Changes:
> 1* Amount of white space, twice. Ignore.
> 2* Use ++i instead of kfree as discussed above.
> 3* Remove conditional test around i2c_transfer, since it isn't necessary
> (if I'm not missing something).

Patch looks good, want to send it to Marcelo, or do you want me to?

thanks,

greg k-h
