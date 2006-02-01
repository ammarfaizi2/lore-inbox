Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161087AbWBAPRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbWBAPRx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 10:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161086AbWBAPRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 10:17:52 -0500
Received: from attila.bofh.it ([213.92.8.2]:48326 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S1161083AbWBAPRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 10:17:51 -0500
Date: Wed, 1 Feb 2006 15:49:17 +0100
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: netdev@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Backward compatibility and WAN netdev configuration
Message-ID: <20060201144917.GA7644@wonderland.linux.it>
References: <m3psm7tksr.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3psm7tksr.fsf@defiant.localdomain>
User-Agent: Mutt/1.5.11
From: md@Linux.IT (Marco d'Itri)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 01, Krzysztof Halasa <khc@pm.waw.pl> wrote:

> a) Currently it consists of mid-layer WAN protocols single module (Cisco
>    HDLC, FR etc.) + low-level hardware HDLC card driver (C101, N2, PCI200SYN
>    etc.). I'm thinking about splitting the protocol module into separate
>    modules - it would make them independent, users would be able to
>    load, say, FR without PPP or X.25 and underlying syncppp, lapb etc.
>    From the technical POV it would be superior to current code but it
>    would require sysadmins to change modprobe.conf, add another modprobe
>    or something like that. Not a real problem but the upgrade can't be
>    automatic.
Why you cannot support autoloading the modules when a specific protocol
is needed?

-- 
ciao,
Marco
