Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbTLBVou (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 16:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264395AbTLBVot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 16:44:49 -0500
Received: from [192.35.37.50] ([192.35.37.50]:14324 "EHLO
	enterprise.atl.lmco.com") by vger.kernel.org with ESMTP
	id S264391AbTLBVor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 16:44:47 -0500
Message-ID: <3FCD07C4.7090205@atl.lmco.com>
Date: Tue, 02 Dec 2003 16:44:36 -0500
From: Aron Rubin <arubin@atl.lmco.com>
Organization: Lockheed Martin ATL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031021
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Justin M. Forbes" <64bit_fedora@comcast.net>
Subject: SII 3512+Seagate on Athlon64 system
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SATA controller SII 3512 not recognized by driver. It looks like SII 
3512 is almost identical to 3112 interface. I copy/paste/alterred all 
code in ide/pci/siimage.[ch] with "3112" in it to "3512". It seems about 
95% functional. Need help with remaining 5%, related to very, very, slow 
controller comms during init with occational "Interrupt Lost" messages. 
Seems like comms are out of sync and then resync over and over. Other 
than that all drive info comes over. Ryan Earl's patch may fix, I would 
be suprised if it was that simple though. I will try later today.

Aron

-- 

ssh aron@rubinium.org cat /dev/brain | grep ^work:

Aron Rubin                       Member, Engineering Staff
Lockheed Martin                  E-Mail: arubin@atl.lmco.com
Advanced Technology Laboratories Phone:  856.792.9865
3 Executive Campus               Fax:    856.792.9930
Cherry Hill, NJ USA 08002        Web:    http://www.atl.lmco.com

