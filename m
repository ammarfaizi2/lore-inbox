Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265039AbTGBP0o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 11:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265043AbTGBP0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 11:26:44 -0400
Received: from mrburns.nildram.co.uk ([195.112.4.54]:62219 "EHLO
	mrburns.nildram.co.uk") by vger.kernel.org with ESMTP
	id S265039AbTGBP0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 11:26:43 -0400
Date: Wed, 2 Jul 2003 16:40:33 +0100
From: Joe Thornber <thornber@sistina.com>
To: Steve Dobbelstein <steved@us.ibm.com>
Cc: dm-devel@sistina.com, Joe Thornber <thornber@sistina.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [dm-devel] Re: [RFC 3/3] dm: v4 ioctl interface
Message-ID: <20030702154033.GG8063@fib011235813.fsnet.co.uk>
References: <OF471CC3D2.35231415-ON85256D57.00541ED2@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF471CC3D2.35231415-ON85256D57.00541ED2@pok.ibm.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 10:23:45AM -0500, Steve Dobbelstein wrote:
> Why the "if (r)"?  Isn't this just the same as:
> 
>             __unbind(md);
>             r = __bind(md, table);
>             up_write(&md->lock);
>             return r;

yep, will change, thanks.

- Joe
