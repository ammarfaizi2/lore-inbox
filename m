Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbUKWGqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbUKWGqQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 01:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbUKWGpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 01:45:49 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:46142 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261154AbUKWGpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 01:45:24 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Message-Flag: Warning: May contain useful information
References: <20041122714.nKCPmH9LMhT0X7WE@topspin.com>
	<20041122714.9zlcKGKvXlpga8EP@topspin.com>
	<20041122225033.GD15634@kroah.com> <52ekil9v1m.fsf@topspin.com>
	<20041123063045.GA22493@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 22 Nov 2004 22:45:02 -0800
In-Reply-To: <20041123063045.GA22493@kroah.com> (Greg KH's message of "Mon,
 22 Nov 2004 22:30:45 -0800")
Message-ID: <52llct83o1.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH][RFC/v1][9/12] Add InfiniBand userspace MAD support
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 23 Nov 2004 06:45:07.0493 (UTC) FILETIME=[F86B5550:01C4D127]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> class_simple_device_add returns a pointer to a struct
    Greg> class_device * that you can then use to create a file in
    Greg> sysfs with.  That should be what you're looking for.

Shouldn't the ABI version be an attribute in /sys/class/infiniband_mad
rather than being per-device?  (I'm already creating several
per-device attributes for the devices I get back from class_simple_device_add).

 - R.
