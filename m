Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317912AbSFNNtr>; Fri, 14 Jun 2002 09:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317913AbSFNNtq>; Fri, 14 Jun 2002 09:49:46 -0400
Received: from ns.suse.de ([213.95.15.193]:2823 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317912AbSFNNtp>;
	Fri, 14 Jun 2002 09:49:45 -0400
Date: Fri, 14 Jun 2002 15:49:45 +0200
From: Dave Jones <davej@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Andrey Panin <pazke@orbita1.ru>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH: NEW SUBARCHITECTURE FOR 2.5.21] support for NCR voyager (3/4/5xxx series)
Message-ID: <20020614154945.M16772@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	James Bottomley <James.Bottomley@steeleye.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Andrey Panin <pazke@orbita1.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <davej@suse.de> <200206140013.g5E0DQR25561@localhost.localdomain> <20020614024547.H16772@suse.de> <20020614134152.GA1293@pazke.ipt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2002 at 05:41:52PM +0400, Andrey Panin wrote:

 > We also have apm.c, bootflag.c and acpi.c which are definetely PC specific.

apm may be present on the others (need visws/voyager folks to comment on
that I guess), but bootflag and acpi I'd suspect not.

 > "Latest" (2.4.17) visws patch which i'm planning to convert for 2.5, uses
 > function MP_processor_info() from generic mpparse.c. May be it makes sence
 > to move to some generic file ?

Is that the one from the visws sourceforge project ?

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
