Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbULPPuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbULPPuJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 10:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbULPPuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 10:50:09 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:64485 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261340AbULPPuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 10:50:03 -0500
Subject: Re: How to add/drop SCSI drives from within the driver?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Matt Domsch <Matt_Domsch@dell.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>, brking@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, bunk@fs.tum.de,
       Andrew Morton <akpm@osdl.org>, "Ju, Seokmann" <sju@lsil.com>,
       "Doelfel, Hardy" <hdoelfel@lsil.com>, "Mukker, Atul" <Atulm@lsil.com>
In-Reply-To: <1103190852.4136.12.camel@laptopd505.fenrus.org>
References: <60807403EABEB443939A5A7AA8A7458B7F5071@otce2k01.adaptec.com>
	 <1102536081.4218.0.camel@localhost.localdomain>
	 <20041215072453.GB17274@lists.us.dell.com>
	 <1103136559.5232.1.camel@mulgrave>
	 <20041215213001.GA9284@lists.us.dell.com>
	 <1103190852.4136.12.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103208085.21806.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Dec 2004 14:41:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-12-16 at 09:54, Arjan van de Ven wrote:
> I'm strongly against adding this. The reason for that is that once an
> ioctl is added, it realistically will and can never go away.
> LSI is free to have their own fork and give that to dell; but they
> should and could have known that it wasn't going to fly. (same I guess
> for adaptec ioctls). The companies who then commit to some schedule
> realize they take a huge risk, but that is no reason to foul up the
> kernel more. 

I agree. I'd like to see an agreed standard interface for dropping and
managing physical volumes and drives, as well as a standard interface
for dropping/managing logical volumes.


