Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270644AbTGNPTW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 11:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270665AbTGNPTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 11:19:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54546 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270644AbTGNPTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 11:19:19 -0400
Date: Mon, 14 Jul 2003 16:34:04 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, John Belmonte <jvb@prairienet.org>
Subject: Re: 2.5.75-mm1 yenta-socket lsPCI IRQ reads incorrect
Message-ID: <20030714163404.A1076@flint.arm.linux.org.uk>
Mail-Followup-To: Michael Frank <mflt1@micrologica.com.hk>,
	Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@suse.cz>, John Belmonte <jvb@prairienet.org>
References: <200307141333.03911.mflt1@micrologica.com.hk> <20030714150435.GB5118@gtf.org> <20030714162138.B31395@flint.arm.linux.org.uk> <200307142318.07232.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307142318.07232.mflt1@micrologica.com.hk>; from mflt1@micrologica.com.hk on Mon, Jul 14, 2003 at 11:18:07PM +0800
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 11:18:07PM +0800, Michael Frank wrote:
> Right, using the dword write function for 16 words or so is OK, but
> rather clumsy for much more than that.

It's config space, that's as good as it gets.

(The last PCI spec I read didn't allow burst accesses to config space,
and it isn't supposed to be a "memory like" space.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

