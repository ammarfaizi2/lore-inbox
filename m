Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVCWNsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVCWNsq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 08:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbVCWNqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 08:46:31 -0500
Received: from users.linvision.com ([62.58.92.114]:17301 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261600AbVCWNpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 08:45:32 -0500
Date: Wed, 23 Mar 2005 14:45:25 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Natanael Copa <mlists@tanael.org>
Cc: aq <aquynh@gmail.com>, "Hikaru1@verizon.net" <Hikaru1@verizon.net>,
       linux-kernel@vger.kernel.org
Subject: Re: forkbombing Linux distributions
Message-ID: <20050323134525.GA5374@harddisk-recovery.com>
References: <e0716e9f05032019064c7b1cec@mail.gmail.com> <20050322112628.GA18256@roll> <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr> <20050322124812.GB18256@roll> <20050322125025.GA9038@roll> <9cde8bff050323025663637241@mail.gmail.com> <1111581459.27969.36.camel@nc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111581459.27969.36.camel@nc>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 01:37:38PM +0100, Natanael Copa wrote:
> On Wed, 2005-03-23 at 19:56 +0900, aq wrote:
> > > /etc/limits does a better job at stopping forkbombs.
> 
> but does not limit processes that are started from the boot scripts. So
> if a buggy non-root service is exploited, an attacker would be able to
> easily shut down the system.

That's easy to fix: set limits from initrd or initramfs.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
