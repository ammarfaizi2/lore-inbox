Return-Path: <linux-kernel-owner+w=401wt.eu-S1750948AbXAIDH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbXAIDH4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 22:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbXAIDH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 22:07:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49846 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbXAIDH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 22:07:56 -0500
Subject: Re: mprotect abuse in slim
From: Arjan van de Ven <arjan@infradead.org>
To: Mimi Zohar <zohar@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       kjhall@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
       safford@watson.ibm.com
In-Reply-To: <OFE2C5A2DE.3ADDD896-ON8525725D.007C0671-8525725D.007D2BA9@us.ibm.com>
References: <OFE2C5A2DE.3ADDD896-ON8525725D.007C0671-8525725D.007D2BA9@us.ibm.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 08 Jan 2007 19:07:25 -0800
Message-Id: <1168312045.3180.140.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Starting with the fdtable, would it help if we move the 
> fdtable tweaking out of slim itself and into helpers?  Or
> can you recommend another way to implement this functionality.

Hi,

maybe this is a silly question, but do you revoke not only the current
fd entries, but also the ones that are pending in UNIX domain sockets
and that are already being sent to the process? If not.. then you might
as well not bother ;)

Greetings,
   Arjan van de Ven
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

