Return-Path: <linux-kernel-owner+w=401wt.eu-S1754013AbWLRNmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013AbWLRNmS (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 08:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754018AbWLRNmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 08:42:18 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:31618 "HELO abra2.bitwizard.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754013AbWLRNmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 08:42:17 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 08:42:16 EST
Date: Mon, 18 Dec 2006 14:35:36 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Olivier Galibert <galibert@pobox.com>,
       "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: Detecting disk I/O errors
Message-ID: <20061218133536.GA7280@harddisk-recovery.com>
References: <20061218130541.GA60506@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061218130541.GA60506@dspnet.fr.eu.org>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 02:05:41PM +0100, Olivier Galibert wrote:
> Is there a way to know if there has been I/O error(s) on a specific
> disk or partition since boot other than parsing dmesg and hoping it's
> both still there and in the expected format?

Use smartctl. It can be started in a monitor mode.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
