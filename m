Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267466AbSLFA3n>; Thu, 5 Dec 2002 19:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267465AbSLFA3n>; Thu, 5 Dec 2002 19:29:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36620 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267467AbSLFA3m>;
	Thu, 5 Dec 2002 19:29:42 -0500
Message-ID: <3DEFF11D.9060206@pobox.com>
Date: Thu, 05 Dec 2002 19:36:45 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: [2.5.50, ACPI] link error
References: <20021205224019.GH7396@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0212051632120.974-100000@localhost.localdomain> <20021206000618.GB15784@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20021206000618.GB15784@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> S3 needs process stopper from kernel/suspend.c. I did not want to have
> #ifdefs all over suspend.c...


Then move it to a different file, that may be shared between various 
CONFIG_xxx features.

