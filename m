Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759716AbWLDE0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759716AbWLDE0l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 23:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759733AbWLDE0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 23:26:40 -0500
Received: from s233-64-196-242.try.wideopenwest.com ([64.233.242.196]:41091
	"EHLO echohome.org") by vger.kernel.org with ESMTP id S1759715AbWLDE0k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 23:26:40 -0500
Reply-To: <Erik@echohome.org>
From: "Erik Ohrnberger" <Erik@echohome.org>
To: <linux-kernel@vger.kernel.org>
Subject: RE: libata update?
Date: Sun, 3 Dec 2006 23:26:44 -0500
Organization: EchoHome.org
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAAK1G98pFUHxLpBlZlaAH3nEBAAAAAA==@EchoHome.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <4572F2B9.7090306@shaw.ca>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: AccW8xK06JwT7hYFQjKz2fcjau+/mAAZ/kmw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Robert Hancock [mailto:hancockr@shaw.ca] 
> Sent: Sunday, December 03, 2006 10:52 AM
> To: erik@echohome.org
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: libata update?
> 
> Erik Ohrnberger wrote:
> > It's been a number of months since I build a custom kernel with the 
> > libata incorporated to deal with multiple Promise EIDE controller 
> > card's 'DMA Expiry' errors.
> > 
> > I'd like to re-build basically the same thing with an 
> updated kernel 
> > and updates libata.  Could someone point me into the right 
> direction 
> > to achieve this?
> > 
> > Thanks in advance
> > Erik.
> 
> All of the PATA stuff was merged in 2.6.19, if you want the 
> very latest and greatest you can try the -mm tree..
> 
> -- 

Not to sound too dense or anything, but is there a HOWTO for this kernel to
enable the libata code?  

I've read through the Documentation/kernel-parameters.txt file, and seems
like all I have to do is include libata.atapi_enabled=1 combined_mode=libata
on the grub.conf line to enable it, but when I boot that kernel with that
option, I get an error message: 'Block device /dev/sda1 is not a valid root
device' and a 'boot() ::' prompt.

Thanks in advance,
	Erik.

