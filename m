Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbTE2HtB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 03:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbTE2HtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 03:49:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13583 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261989AbTE2HtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 03:49:00 -0400
Date: Thu, 29 May 2003 09:02:09 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: CaT <cat@zip.com.au>, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70: pcmcia oops (a real one! honest!)
Message-ID: <20030529090209.B12513@flint.arm.linux.org.uk>
Mail-Followup-To: CaT <cat@zip.com.au>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <20030528042610.GD6501@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030528042610.GD6501@zip.com.au>; from cat@zip.com.au on Wed, May 28, 2003 at 02:26:10PM +1000
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 02:26:10PM +1000, CaT wrote:
> removed my xircom pcmcia realport card and put in another. End result was
> total loss of ps2 keyboard functionality (everything else, inc the ps2 mouse
> still works). I then removed the xircom card. The following was in dmesg:

I'm assuming that this is something Gregkh needs to look into and not
myself; my guess is that it's related to the pci device accounting stuff.

Greg?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

