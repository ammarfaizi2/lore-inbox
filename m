Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbUK3RWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbUK3RWq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 12:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbUK3RWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 12:22:46 -0500
Received: from users.linvision.com ([62.58.92.114]:43924 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262204AbUK3RRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 12:17:40 -0500
Date: Tue, 30 Nov 2004 18:17:39 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Walking all the physical memory in an x86 system
Message-ID: <20041130171739.GB28284@harddisk-recovery.com>
References: <C863B68032DED14E8EBA9F71EB8FE4C2057CA977@azsmsx406> <Pine.LNX.4.53.0411301711140.25731@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0411301711140.25731@yvahk01.tjqt.qr>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 05:12:01PM +0100, Jan Engelhardt wrote:
> what have They done with /dev/mem? ... one once could access e.g.
> position 0x400 of /dev/mem (by seeking) and then read the LPT port value.

For AFAIK, LPT ports have never been memory mapped on PCs. They live in
the IO space, usually at 0x378 (or 0x278).


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
