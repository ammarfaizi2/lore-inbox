Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268220AbTBNGWg>; Fri, 14 Feb 2003 01:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268221AbTBNGWf>; Fri, 14 Feb 2003 01:22:35 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:272 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S268220AbTBNGWd>; Fri, 14 Feb 2003 01:22:33 -0500
Date: Fri, 14 Feb 2003 06:32:25 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Sahara Workshop <workshop@cpt.saharapc.co.za>
Cc: Christoph Hellwig <hch@infradead.org>, KML <linux-kernel@vger.kernel.org>
Subject: Re: Problems with 2.5.*'s SCSI headers and cdrtools
Message-ID: <20030214063225.A19016@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Sahara Workshop <workshop@cpt.saharapc.co.za>,
	KML <linux-kernel@vger.kernel.org>
References: <1045201685.5971.78.camel@workshop.saharact.lan> <20030214055822.A18415@infradead.org> <1045202851.5971.83.camel@workshop.saharact.lan> <20030214062109.A18761@infradead.org> <1045204070.5971.92.camel@workshop.saharact.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1045204070.5971.92.camel@workshop.saharact.lan>; from workshop@cpt.saharapc.co.za on Fri, Feb 14, 2003 at 08:27:50AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 08:27:50AM +0200, Sahara Workshop wrote:
> > Glibc's <scsi/scsi.h>
> 
> 
> If you looked at the patch, you would have seen that it
> does include 'scsi/scsi.h', but I'm guessing its changing the
> search order of includes then.  Ill have a look.

Either your distributions setup is broken and overwrites
/usr/include/scsi/scsi.h (check whether it has the FSF copyright,
they took the kernel header verbatim and just slapped their copyright
boilerplate over it..) or cdrtools is broken enough to explicitly
add the kernel source to it's include dirs.  Both would need fixing,
the first is easy, the second needs conviencing Joerg which might
become difficult :)

