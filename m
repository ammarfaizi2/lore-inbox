Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWGRVNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWGRVNi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 17:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWGRVNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 17:13:38 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:22490 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750719AbWGRVNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 17:13:38 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Mark Lord <lkml@rtr.ca>
Subject: Re: FYI: strange libata EH lines in dmesg once after every bootup
Date: Tue, 18 Jul 2006 23:13:28 +0200
User-Agent: KMail/1.9.3
Cc: Christian Trefzer <ctrefzer@gmx.de>, lkml <linux-kernel@vger.kernel.org>
References: <20060714230801.GA6645@zeus.uziel.local> <20060715004845.GA26446@zeus.uziel.local> <44B8E19E.2060904@rtr.ca>
In-Reply-To: <44B8E19E.2060904@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607182313.30152.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Saturday, 15. July 2006 14:37, Mark Lord wrote:
> Okay.  Most likely your drive doesn't support the autosave features.
> 
> Just do "smartctl -d ata -a /dev/sdb" to see what it does support,
> and then change the system startup scripts to not issue any unsupported
> commands -- that'll get rid of those harmless boot time error messages.

Would it be very difficult to tell the user 
"you issued unsupported command FOOBAR"
and ignore it after a while?

That way people can swap drives without reconfiguring smartscripts :-)

Support either in smartctl or kernel would be ok. Whereever you see fit.

Regards

Ingo Oeser
