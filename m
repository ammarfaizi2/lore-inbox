Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWEOI3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWEOI3j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 04:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWEOI3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 04:29:39 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:43915 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S964810AbWEOI3i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 04:29:38 -0400
Subject: Re: [PATCH] add raw driver Kconfig entry for s390
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060513115255.GA11955@suse.de>
References: <20060513115255.GA11955@suse.de>
Content-Type: text/plain
Organization: IBM Corporation
Date: Mon, 15 May 2006 10:30:00 +0200
Message-Id: <1147681800.5306.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-13 at 13:52 +0200, Olaf Hering wrote:
> From: Ihno Krumreich <ihno@suse.de>
> 
> The raw module is not enabled on s390/s390x
> During SLES9 and SLES10 development IBM filed bugs about the missing raw
> driver. Avoid that for SLES11 by adding it to the other char driver
> entries.
> 
> Signed-off-by: Olaf Hering <olh@suse.de>

NACK. The raw device driver is obsolete and we should not add it to the
s390 kconfig. I know that it is needed in SLES10 for compatability to
SLES9 but given that the option is supposed to vanish I prefer to keep
it out of the upstream tree.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


