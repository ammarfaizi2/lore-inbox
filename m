Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbUKWCLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbUKWCLy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 21:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbUKWCJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 21:09:44 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:29211 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262451AbUKWCI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 21:08:27 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Message-Flag: Warning: May contain useful information
References: <20041122714.nKCPmH9LMhT0X7WE@topspin.com>
	<20041122714.9zlcKGKvXlpga8EP@topspin.com>
	<20041122225033.GD15634@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 22 Nov 2004 18:08:21 -0800
In-Reply-To: <20041122225033.GD15634@kroah.com> (Greg KH's message of "Mon,
 22 Nov 2004 14:50:33 -0800")
Message-ID: <52ekil9v1m.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH][RFC/v1][9/12] Add InfiniBand userspace MAD support
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 23 Nov 2004 02:08:26.0571 (UTC) FILETIME=[517FA9B0:01C4D101]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> This could be in a sysfs file, right?

Ugh, how does one add an attribute (like the ABI version) to a
class_simple?  It shouldn't be per-device but I don't see anything
like class_create_file() that could work for class_simple.

Thanks,
  Roland
