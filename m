Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261816AbSJDWJD>; Fri, 4 Oct 2002 18:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263081AbSJDWJD>; Fri, 4 Oct 2002 18:09:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58121 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261816AbSJDWJC>; Fri, 4 Oct 2002 18:09:02 -0400
Date: Fri, 4 Oct 2002 23:14:32 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] pcibios_* removals for 2.5.40
Message-ID: <20021004231432.E31015@flint.arm.linux.org.uk>
References: <20021003224011.GA2289@kroah.com> <Pine.LNX.4.44.0210040930581.1723-100000@home.transmeta.com> <20021004165955.GC6978@kroah.com> <20021004205121.GA8346@kroah.com> <20021004205222.GB8346@kroah.com> <3D9E0AB7.8090905@pobox.com> <20021004215350.GB8843@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021004215350.GB8843@kroah.com>; from greg@kroah.com on Fri, Oct 04, 2002 at 02:53:51PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 02:53:51PM -0700, Greg KH wrote:
> Heh, again, this driver needs some major work in regards to PCI
> cleanups, it's quite old.  It can probably be converted over to use the
> drivers/serial core too.

I have a version of this which is mostly converted; its pending me fixing
the write() method in the core driver.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

