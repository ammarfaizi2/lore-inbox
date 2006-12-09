Return-Path: <linux-kernel-owner+w=401wt.eu-S1947618AbWLIBRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947618AbWLIBRq (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 20:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761343AbWLIBRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 20:17:46 -0500
Received: from cantor.suse.de ([195.135.220.2]:44658 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761341AbWLIBRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 20:17:45 -0500
Date: Fri, 8 Dec 2006 17:17:24 -0800
From: Greg KH <gregkh@suse.de>
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Stefan Reinauer <stepan@coresystems.de>,
       Peter Stuge <stuge-linuxbios@cdy.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 2/2] x86_64: earlyprintk usb debug device support.
Message-ID: <20061209011723.GC16576@suse.de>
References: <5986589C150B2F49A46483AC44C7BCA4907299@ssvlexmb2.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA4907299@ssvlexmb2.amd.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 07:20:16PM -0800, Lu, Yinghai wrote:
> Greg,
> 
> I wonder why the netconsole could print all boot log from beginning with
> buffer. But your usb serial console can not.

Buffer size?  flow control?  the fact that the buffer has already
overflowed?  Who knows, don't trust usb-serial as a real "console"
please :)

thanks,

greg k-h
