Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbULQRRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbULQRRG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 12:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbULQRRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 12:17:06 -0500
Received: from boa.mtg-marinetechnik.de ([62.153.155.10]:65006 "EHLO
	cascabel.mtg-marinetechnik.de") by vger.kernel.org with ESMTP
	id S262078AbULQRPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 12:15:44 -0500
Message-ID: <41C31421.7090102@mtg-marinetechnik.de>
Date: Fri, 17 Dec 2004 18:15:13 +0100
From: Richard Ems <richard.ems@mtg-marinetechnik.de>
Organization: MTG Marinetechnik GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, de, es
MIME-Version: 1.0
To: Jon Mason <jdmason@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <200412171100.16601.richard.ems@mtg-marinetechnik.de> <89245775041217090726eb2751@mail.gmail.com>
In-Reply-To: <89245775041217090726eb2751@mail.gmail.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Subject: Re: PROBLEM: Network hang: "eth0: Tx timed out (f0080), is buffer 
  full?" (Plain)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Mason wrote:
> It seems to me the cause of the tx timeouts is the "HostError", which
> is a PCI bus error.  This most likely caused the adapter to hang and
> then the transmits started timing out.
> 
> As far as I can tell, the dl2k driver code is common between 2.4 and
> 2.6.  So, some other change in the kernel is causing the driver to
> behave differently and expose this problem.
> 
> I am not the maintainer, but I can try to assist you. However, it will
> require running debug drivers (as I am not able to find any
> documentation on this adapter).  If you are not willing or able to do
> this, then I would suggest going back to the 2.4 kernel.

Ok, yes, I'm willing to try your debug drivers. We'll see if I'm also 
able ;-)

What shall I do?

Thanks ,Richard

-- 
Richard Ems

MTG Marinetechnik GmbH
Wandsbeker Königstr. 62
22041 Hamburg
Telefon: +49 40 65803 312
TeleFax: +49 40 65803 392
mail: richard.ems@mtg-marinetechnik.de

