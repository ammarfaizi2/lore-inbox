Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbVHALqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVHALqj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 07:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVHALqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 07:46:38 -0400
Received: from magic.adaptec.com ([216.52.22.17]:32908 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S262188AbVHALqi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 07:46:38 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: AACRAID failure with 2.6.13-rc1
Date: Mon, 1 Aug 2005 07:44:41 -0400
Message-ID: <60807403EABEB443939A5A7AA8A7458B01792901@otce2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: AACRAID failure with 2.6.13-rc1
Thread-Index: AcWUd/QK4qDICGvDQ6aI/cp3RPOtjwCFmISA
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <drab@kepler.fjfi.cvut.cz>, <linux-kernel@vger.kernel.org>,
       <markh@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, please put the workaround into 2.6.13!

Sincerely -- Mark Salyzyn

-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org] 
Sent: Friday, July 29, 2005 3:59 PM
To: Salyzyn, Mark
Cc: drab@kepler.fjfi.cvut.cz; linux-kernel@vger.kernel.org;
markh@osdl.org
Subject: Re: AACRAID failure with 2.6.13-rc1

"Salyzyn, Mark" <mark_salyzyn@adaptec.com> wrote:
>
> Martin may be overplaying the performance angle.
> 
> A previous patch took the adapter from 64K to 4MB transaction sizes
> across the board. This caused Martin's adapter and drive combination
to
> tip-over. We had to scale back to 128KB sized transactions to get
> stability on his system. All systems handled the 4MB I/O size in our
> tests, but the tests that were done some time ago were not performed
> with the latest kernel, which contributed to a change in testing
> corners.

Confused.  The above appears to indicate that we should put the
workaround
into 2.6.13, yes?

