Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132122AbRC1TkW>; Wed, 28 Mar 2001 14:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132143AbRC1TkO>; Wed, 28 Mar 2001 14:40:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43794 "EHLO www.linux.org.uk") by vger.kernel.org with ESMTP id <S132122AbRC1TkF>; Wed, 28 Mar 2001 14:40:05 -0500
Date: Wed, 28 Mar 2001 20:39:20 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Erik Hensema <erik@hensema.xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NTP on 2.4.2?
Message-ID: <20010328203920.D6867@flint.arm.linux.org.uk>
References: <20010323162345.A24604@flint.arm.linux.org.uk> <20010328202245.B3304@hensema.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010328202245.B3304@hensema.xs4all.nl>; from erik@hensema.xs4all.nl on Wed, Mar 28, 2001 at 08:22:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2001 at 08:22:45PM +0200, Erik Hensema wrote:
> On Fri, Mar 23, 2001 at 04:23:45PM +0000, Russell King wrote:
> > I'm having problems getting my 2.4.2 kernel to synchronise properly.  For
> > some reason, NTP is insisting on making time offset adjustments.
> 
> It isn't a GMT vs localtime issue, I presume?

No, I solved the problem - the 100Hz interrupt wasn't close enough to 100Hz
to allow NTP to do its job.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

