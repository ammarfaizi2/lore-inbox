Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268442AbTGIRyb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 13:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268451AbTGIRyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 13:54:31 -0400
Received: from granite.he.net ([216.218.226.66]:40198 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S268442AbTGIRy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 13:54:29 -0400
Date: Wed, 9 Jul 2003 10:38:16 -0700
From: Greg KH <greg@kroah.com>
To: Disconnect <lkml@sigkill.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BUG][USB] 2.4.22-pre2
Message-ID: <20030709173816.GA17421@kroah.com>
References: <1057769826.8465.30.camel@slappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057769826.8465.30.camel@slappy>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 12:57:06PM -0400, Disconnect wrote:
> Its dead simple to reproduce - plug a pl2303 in, open /dev/ttyUSB0 with
> (eg) minicom or pppd, close it, check logs.

Known bug, search the archives :)

It's fixed in 2.5.

Someone needs to backport the 2.5 changes to 2.4 to fix this issue, as
I'm getting tired of repeating myself...

thanks,

greg k-h
