Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261609AbTCYHan>; Tue, 25 Mar 2003 02:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261617AbTCYHan>; Tue, 25 Mar 2003 02:30:43 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:11537 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261609AbTCYHah>;
	Tue, 25 Mar 2003 02:30:37 -0500
Date: Mon, 24 Mar 2003 23:41:12 -0800
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       sensors@Stimpy.netroedge.com
Subject: Re: How to convert i2c adapter drivers into good kernel code
Message-ID: <20030325074112.GG12590@kroah.com>
References: <20030325072511.GD12590@kroah.com> <20030325073834.B30897@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325073834.B30897@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 07:38:34AM +0000, Christoph Hellwig wrote:
> On Mon, Mar 24, 2003 at 11:25:12PM -0800, Greg KH wrote:
> >    line in the driver, and replace the LM_VERSION and LM_DATE entries
> >    with I2C_VERSION and I2C_DATE to fix that compile time error.
> 
> That's bogus.  Replace LM_VERSION with the lm_sensors version you took it
> from + lk1 (e.g. "2.7.0-lk1) and LM_DATE with your modification date.
> Or just remove them altogether..

Fine with me, I was just trying to copy what I had seen done for the
other drivers already in the kernel.  version and dates don't really
make _any_ sense once the driver is in the kernel, so I'd recommend just
removing them altogether too.

thanks,

greg k-h
