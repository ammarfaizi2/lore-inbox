Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbTDDHpv (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 02:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263469AbTDDHpv (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 02:45:51 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:49042 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263468AbTDDHpZ (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 02:45:25 -0500
Date: Fri, 4 Apr 2003 09:56:52 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, steve.cameron@hp.com
Subject: Re: [PATCH] reduce stack in cpqarray.c::ida_ioctl()
Message-ID: <20030404075652.GA13651@wohnheim.fh-wedel.de>
References: <20030403120308.620e5a14.rddunlap@osdl.org> <20030404003044.GB16832@wohnheim.fh-wedel.de> <20030403173352.0311312a.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030403173352.0311312a.rddunlap@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 April 2003 17:33:52 +0000, Randy.Dunlap wrote:
> 
> | > +		error = copy_to_user(io, my_io, sizeof(*my_io)) ? -EFAULT : 0;
> | 
> | copy_to_user returns the bytes successfully copied.
> | error is set to -EFAULT, if there was actually data transferred?
> 
> Did you verify that?

Yes, but I do make mistakes. Better double-check it yourself.

Jörn

-- 
"Error protection by error detection and correction."
-- from a university class
