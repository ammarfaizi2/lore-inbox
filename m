Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267454AbTBNIkI>; Fri, 14 Feb 2003 03:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268240AbTBNIkI>; Fri, 14 Feb 2003 03:40:08 -0500
Received: from [196.41.29.142] ([196.41.29.142]:50956 "EHLO
	andromeda.cpt.sahara.co.za") by vger.kernel.org with ESMTP
	id <S267454AbTBNIkH>; Fri, 14 Feb 2003 03:40:07 -0500
Subject: Re: Problems with 2.5.*'s SCSI headers and cdrtools
From: Martin Schlemmer <azarah@gentoo.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030214063225.A19016@infradead.org>
References: <1045201685.5971.78.camel@workshop.saharact.lan>
	 <20030214055822.A18415@infradead.org>
	 <1045202851.5971.83.camel@workshop.saharact.lan>
	 <20030214062109.A18761@infradead.org>
	 <1045204070.5971.92.camel@workshop.saharact.lan>
	 <20030214063225.A19016@infradead.org>
X-scanner: scanned by Sistech VirusWall 2.3/cpt
Content-Type: text/plain
Organization: 
Message-Id: <1045212517.3285.96.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1- 
Date: 14 Feb 2003 10:48:38 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-14 at 08:32, Christoph Hellwig wrote:

> Either your distributions setup is broken and overwrites
> /usr/include/scsi/scsi.h (check whether it has the FSF copyright,
> they took the kernel header verbatim and just slapped their copyright
> boilerplate over it..) or cdrtools is broken enough to explicitly
> add the kernel source to it's include dirs.  Both would need fixing,
> the first is easy, the second needs conviencing Joerg which might
> become difficult :)
> 

Thanks.  Ill look into this, and also check with Joerg why it have to
use the current kernel headers if it is what its doing.  I just
basically wanted the opinion of what should be the right way to handle
it before I submit a bug report to the correct people.

Are scsi stuff in 2.5 going to change drastically in the future ?


Regards,

-- 
Martin Schlemmer
Gentoo Linux Developer, Desktop Team
Cape Town, South Africa

