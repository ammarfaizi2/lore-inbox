Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWHBV0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWHBV0u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWHBV0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:26:50 -0400
Received: from mail.visionpro.com ([63.91.95.13]:21476 "EHLO
	chicken.machinevisionproducts.com") by vger.kernel.org with ESMTP
	id S932143AbWHBV0t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:26:49 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: Problems with mtpscsih kernel module
Date: Wed, 2 Aug 2006 14:26:48 -0700
Message-ID: <14CFC56C96D8554AA0B8969DB825FEA0012B3941@chicken.machinevisionproducts.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with mtpscsih kernel module
Thread-Index: Aca2elzEG1NQcdp5TL642zYgs43MRw==
From: "Brian D. McGrew" <brian@visionpro.com>
To: "For users of Fedora Core releases" <fedora-list@redhat.com>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running on a Dell PowerEdge 1800 using Fedora Core 3 and a 2.6.16.16
kernel.

I've built up this new kernel to roll out to our production systems and
it's been in test on a PE1800 for a long time and working fine.
However, the machine that it's been testing on has SATA drives.
Yesterday I moved it to a production system, another PE1800 with SCSI
drives and I'm getting an error

Insmod /lib/modules/mptscshih.ko: -l unknown symbol

The only differences I can find between the two machines is that the
original build/test machine has gcc-3.4.4 and the new machine has
gcc-3.4.2; but it looks like all the system libraries are the same and
everything else.

I even went so far as to move the entire source tree to this machine and
do a make clean and rebuild and reinstall and I'm still having the same
problem.  What am I missing here???  

Thanks! Problems with mtpscsih kernel module

:b!

Brian D. McGrew { brian@visionpro.com || brian@doubledimension.com }
--
> This is a test.  This is only a test!
  Had this been an actual emergency, you would have been
  told to cancel this test and seek professional assistance!

