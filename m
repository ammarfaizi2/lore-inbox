Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262384AbTBSWxy>; Wed, 19 Feb 2003 17:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbTBSWxy>; Wed, 19 Feb 2003 17:53:54 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:2734 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262384AbTBSWxy>;
	Wed, 19 Feb 2003 17:53:54 -0500
Subject: Re: [PATCH] IPSec protocol application order
To: "David S. Miller" <davem@redhat.com>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF67D9F550.2E100257-ON86256CD2.007CE0BF-86256CD2.007E9FBD@pok.ibm.com>
From: "Tom Lendacky" <toml@us.ibm.com>
Date: Wed, 19 Feb 2003 17:03:04 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 02/19/2003 06:03:08 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> setkey is for manual keying and debugging.  Therefore, disallowing
> experimenting with non-rfc-compliant orderings seems to lack purpose
> to me.

I apologize if I missed it, but is there another way to set policy in the
SPD besides the setkey command?  I am under the assumption that setkey's
spdadd operation is what is to be used to define the policy on the system
so that racoon can perform dynamic keying.

Tom


