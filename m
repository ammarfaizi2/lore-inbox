Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266352AbUJIDJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266352AbUJIDJz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 23:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUJIDJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 23:09:55 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:30287 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266352AbUJIDJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 23:09:53 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <20041008202247.GA9653@kroah.com> <528yagn63x.fsf@topspin.com>
	<41673772.9010402@pobox.com>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 08 Oct 2004 20:09:50 -0700
In-Reply-To: <41673772.9010402@pobox.com> (Jeff Garzik's message of "Fri, 08
 Oct 2004 20:57:22 -0400")
Message-ID: <52zn2wlh8h.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [openib-general] InfiniBand incompatible with the Linux kernel?
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 09 Oct 2004 03:09:51.0497 (UTC) FILETIME=[714BFF90:01C4ADAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jeff> Read the member agreement :) It -explicitly- does -not-
    Jeff> require waiving of patent claims related to any
    Jeff> implementation of IB.

    Jeff> That's different from ATA, SCSI, USB, the list goes on...

Fair enough, but read the Bluetooth SIG patent agreement [1].  As far
as I can tell, all it requires is that other SIG members receive a
patent license.  Do we need to do rm -rf net/bluetooth?  IEEE only
requires that patents be licensed under RAND terms (it does not even
require royalty free licensing) [2].  Time for rm -rf drivers/ieee1394?

The code that we have written so far is pretty standard driver code,
so I have a hard time believing that the IB drivers are any more at
risk than any other Linux code.  There may be good and valid reasons
not to merge IB drivers upstream, but I'd be very disappointed if this
FUD about patents is what keeps them out.

Thanks,
  Roland

[1]  https://www.bluetooth.org/foundry/sitecontent/document/Patent_and_Copyright_License_Agreement

[2]  http://standards.ieee.org/guides/bylaws/sect6-7.html#6
