Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbTEMWqb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263550AbTEMWpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:45:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37896 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263558AbTEMWpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:45:03 -0400
Date: Tue, 13 May 2003 23:55:28 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69: Missing logo?
Message-ID: <20030513235528.H15172@flint.arm.linux.org.uk>
Mail-Followup-To: James Simmons <jsimmons@infradead.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030506180707.B15174@flint.arm.linux.org.uk> <Pine.LNX.4.44.0305132334140.12672-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0305132334140.12672-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Tue, May 13, 2003 at 11:41:34PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 11:41:34PM +0100, James Simmons wrote:
> At the very bottom of cfbimgblt.c change 
> 
> } else if (image->depth == bpp)
> 
> to 
> 
> } else if (image->depth <= bpp)
> 
> and tell me if this works.

Will report later.

> P.S
>   Is it possible we could move the irq code for the acorn driver from 
> fbcon.c to the acorn driver itself. 

I don't see why not.  Do you have a patch for this?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

