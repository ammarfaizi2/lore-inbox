Return-Path: <linux-kernel-owner+w=401wt.eu-S1751738AbWLVSMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbWLVSMy (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 13:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbWLVSMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 13:12:54 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:37873 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbWLVSMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 13:12:53 -0500
From: Oliver Neukum <oliver@neukum.org>
To: J <jhnlmn@yahoo.com>, Greg KH <gregkh@suse.de>
Subject: Re: Possible race condition in usb-serial.c
Date: Fri, 22 Dec 2006 19:14:40 +0100
User-Agent: KMail/1.8
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <224234.7202.qm@web32911.mail.mud.yahoo.com>
In-Reply-To: <224234.7202.qm@web32911.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612221914.41111.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 20. Dezember 2006 23:24 schrieb J:
> > Could you test the attached patch against 2.6?
> 
> Alas, I only have an old 2.4 right now.
> May be I will install 2.6 later (in few weeks).
> Currently I am just trying to read 2.6 code with my
> eyes.
> 
> I studied the patch, which you sent.
> I don't see obvious errors, but, in my opinion, it is
> not completely perfect.

Please disregard the patch. I overlooked serial_read_proc().
This problem will need some deeper surgery probably involving
removal of the refcounting.

But not during Christmas.

	Regards
		Oliver
