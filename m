Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbRFUT4l>; Thu, 21 Jun 2001 15:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265176AbRFUT4c>; Thu, 21 Jun 2001 15:56:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48396 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265174AbRFUT4L>;
	Thu, 21 Jun 2001 15:56:11 -0400
Date: Thu, 21 Jun 2001 20:55:37 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Eric S. Raymond" <esr@thyrsus.com>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Missing help entries in 2.4.6pre5
Message-ID: <20010621205537.X18978@flint.arm.linux.org.uk>
In-Reply-To: <20010621154934.A6582@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010621154934.A6582@thyrsus.com>; from esr@thyrsus.com on Thu, Jun 21, 2001 at 03:49:34PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2001 at 03:49:34PM -0400, Eric S. Raymond wrote:
> CONFIG_XSCALE_IQ80310

I think we've covered this one before.

This symbol only exists as an undefined reference at the moment, and
therefore can never be 'y'.  As such, there is little point in providing
help for it.

Even the master ARM tree doesn't contain its definition yet, so please,
stop bringing it up.

The reason you have it is that stuff has come via a different route which
relies on it - via the MTD CVS tree.

The symbol is therefore currently irrelevent, and can be placed on your
"ignore" list.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

