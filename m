Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136784AbREIRoI>; Wed, 9 May 2001 13:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136783AbREIRn7>; Wed, 9 May 2001 13:43:59 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:19610 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S136785AbREIRny>; Wed, 9 May 2001 13:43:54 -0400
Message-ID: <3AF981DA.B03FA032@austin.ibm.com>
Date: Wed, 09 May 2001 12:43:54 -0500
From: "Andrew M. Theurer" <atheurer@austin.ibm.com>
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Mike Kravetz <mkravetz@sequent.com>, lse-tech@lists.sourceforge.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        samba-technical <samba-technical@samba.org>
Subject: Re: Linux 2.4 Scalability, Samba, and Netbench
In-Reply-To: <E14xXvT-0002ri-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>
> > significant problems with lockmeter.  csum_partial_copy_generic was the
> > highest % in profile, at 4.34%.  I'll see if we can get some space on
> 
> Are you using Antons optimisations to samba to use sendfile ?
> 
> Alan

Not yet.  As I understand it, we need a supported nic to take advantage
of the sendfile/zero copy patch.  Once we have the HW, we will use it.

Thanks,

Andrew Theurer
