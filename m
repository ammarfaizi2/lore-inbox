Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275300AbTHSCWi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 22:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275303AbTHSCWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 22:22:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49859 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S275300AbTHSCWh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 22:22:37 -0400
Message-ID: <3F4189E1.5010808@pobox.com>
Date: Mon, 18 Aug 2003 22:22:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Brown, Len" <len.brown@intel.com>
CC: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.x ACPI updates
References: <BF1FE1855350A0479097B3A0D2A80EE009FC79@hdsmsx402.hd.intel.com>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FC79@hdsmsx402.hd.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brown, Len wrote:
> The ISO_8859_1 acute accent, u with diaeresis, and registered sign, have been in Config.info since Feb 2002.
> 
> Andy's tools seem to have extended them to 16-bit characters during a merge.  A "minor gaff"?  Okay, I guess that's fair.  He promises that he doesn't know how to type a latin capital A with a circumflex on his keyboard;-).
> 
> Moving on...  Is the fix to restore the 8-bit characters, or use 7-bit characters?


Just sent a private message, but to relate the process to others as well...

The fix is to ensure that the ACPI updates sent to Marcelo never touch 
areas of Documentation/Configure.help that do not relate to ACPI ;-) 
Whatever characters are currently in Configure.help, just leave them be :)

	Jeff, being a UTF8 fan, is pained saying this...



