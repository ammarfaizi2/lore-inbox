Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbUBXREl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 12:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbUBXREc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 12:04:32 -0500
Received: from mail.kroah.org ([65.200.24.183]:44431 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262306AbUBXREY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 12:04:24 -0500
Date: Tue, 24 Feb 2004 09:04:13 -0800
From: Greg KH <greg@kroah.com>
To: Kai Makisara <Kai.Makisara@metla.fi>
Cc: Linus Torvalds <torvalds@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, kai.makisara@kolumbus.fi
Subject: Re: [BK PATCH] SCSI update for 2.6.3
Message-ID: <20040224170412.GA31268@kroah.com>
References: <Pine.LNX.4.58.0402240919490.1129@spektro.metla.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0402240919490.1129@spektro.metla.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 09:30:01AM +0200, Kai Makisara wrote:
> On Tue, 24 Feb 2004, Linus Torvalds wrote:
> >On Mon, 23 Feb 2004, James Bottomley wrote:
> >>
> >> Kai Mäkisara:
> >> o Sysfs class support for SCSI tapes
> >
> >Has this been checked for correctness, or will Al flame me to a crisp for
> >accepting it? Pls verify..
> 
> It is using the class_simple interface Greg KH said can be used without
> changes to driver's lifetime rules. If this is not true, then I have to
> rework the patch. The code was posted to linux-scsi on Feb 5 but I would
> not count on any serious review being done there.

Can you post it here so we can review it?

And yes, using class_simple should relieve you of Al flamage :)

thanks,

greg k-h
