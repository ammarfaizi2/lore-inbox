Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266703AbUJNQNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266703AbUJNQNv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 12:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUJNQNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 12:13:46 -0400
Received: from mail3.utc.com ([192.249.46.192]:41615 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S266703AbUJNQJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 12:09:26 -0400
Message-ID: <416EA4AC.7040006@cybsft.com>
Date: Thu, 14 Oct 2004 11:09:16 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Steven A. DuChene" <linux-clusters@mindspring.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: AIC-7899 not found with 2.6.9-rc4-mm1
References: <20041014062848.U22429@lapsony.mydomain.here>
In-Reply-To: <20041014062848.U22429@lapsony.mydomain.here>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven A. DuChene wrote:
> I have a system with two on-board SCSI controllers (see lsoci output below)
> and one AHA-2940U stuck into a PCI slot. The on-board controllers are Adaptec
> AIC-7899P U160 chips on the Intel server mboard. I have been running the system with
> 2.6.8-rc4-mm1 but detected some abnormalities with NFS server subsystem stuff
> so I decided to update to 2.6.9-rc4-mm1 however when I did so only the AHA-2940U
> card that is stuck into the PCI slot is found. Since this is not the controller
> with the disks attached the system is not able to find it's root filesystem.

I have the same problem. Backing out bk-scsi.patch and 
bk-scsi-target.patch will solve this temporarily.

kr
