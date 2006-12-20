Return-Path: <linux-kernel-owner+w=401wt.eu-S965161AbWLTVAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbWLTVAr (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 16:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbWLTVAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 16:00:47 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:58084 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965161AbWLTVAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 16:00:46 -0500
From: Oliver Neukum <oliver@neukum.org>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Possible race condition in usb-serial.c
Date: Wed, 20 Dec 2006 22:02:29 +0100
User-Agent: KMail/1.8
Cc: Alan Stern <stern@rowland.harvard.edu>, J <jhnlmn@yahoo.com>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0612201009580.3072-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0612201009580.3072-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612202202.30028.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 20. Dezember 2006 16:10 schrieb Alan Stern:
> On Wed, 20 Dec 2006, Oliver Neukum wrote:

> > People, do we take BKL in khubd?
> 
> Nope.

OK. I've taken measures to correct the problem.

	Regards
		Oliver
