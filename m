Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVAYLOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVAYLOX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 06:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVAYLOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 06:14:23 -0500
Received: from mail9.messagelabs.com ([194.205.110.133]:41368 "HELO
	mail9.messagelabs.com") by vger.kernel.org with SMTP
	id S261891AbVAYLOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 06:14:19 -0500
X-VirusChecked: Checked
X-Env-Sender: icampbell@arcom.com
X-Msg-Ref: server-24.tower-9.messagelabs.com!1106651658!15977683!1
X-StarScan-Version: 5.4.5; banners=arcom.com,-,-
X-Originating-IP: [194.200.159.164]
Subject: Re: RFC: use datacs is smc91x driver
From: Ian Campbell <icampbell@arcom.com>
To: Nicolas Pitre <nico@cam.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0501241459090.7307@localhost.localdomain>
References: <1106569302.19123.49.camel@icampbell-debian>
	 <Pine.LNX.4.61.0501241459090.7307@localhost.localdomain>
Content-Type: text/plain
Organization: Arcom Control Systems
Date: Tue, 25 Jan 2005 11:14:16 +0000
Message-Id: <1106651657.19123.54.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-IMAIL-SPAM-VALHELO: (1926824222)
X-IMAIL-SPAM-VALREVDNS: (1926824222)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-24 at 15:20 -0500, Nicolas Pitre wrote:
> On Mon, 24 Jan 2005, Ian Campbell wrote:
> > I'm not entirely happy with using the SMC_*_RESOURCE defines to find the
> > correct resources, but I don't think you can have a placeholder for the
> > attrib space at index 1 (when you don't have an attrib space) and still
> > have datacs at index 2.
> 
> I don't like that either.  Maybe the whole thing should be converted to 
> use platform_get_resource_byname() ?

Ah, I hadn't seen this new function, it looks ideal. I'll work up
another that uses it and updates all the in tree drivers. 

Are you happy with "iocs", "attrib" and "datacs" for the names?

Ian.

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been virus scanned by MessageLabs.
