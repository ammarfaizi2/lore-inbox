Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268504AbUHLKna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268504AbUHLKna (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 06:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268505AbUHLKn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 06:43:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:7657 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268504AbUHLKn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 06:43:27 -0400
Subject: Re: [PATCH] SCSI midlayer power management
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@suse.cz>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Nathan Bryant <nbryant@optonline.net>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20040812074520.GE29466@elf.ucw.cz>
References: <4119611D.60401@optonline.net>
	 <20040811080935.GA26098@elf.ucw.cz> <411A1B72.1010302@optonline.net>
	 <1092231462.2087.3.camel@mulgrave> <1092267400.2136.24.camel@gaston>
	 <20040812074520.GE29466@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1092307081.26432.0.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 12 Aug 2004 20:38:03 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hmm, and it can not be handled by "just remember why you were
> suspended", because it is one suspend, two resumes...
> 
> Yes, I agree that argument will be usefull. Just who does all the
> driver updating? ;-).

At this point, no driver cares, so it's just a matter of fixing the
prototypes, I'll leave that to somebody more familiar with sed :)

Ben.


