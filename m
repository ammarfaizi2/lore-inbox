Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264683AbTFQMXz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 08:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264685AbTFQMXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 08:23:55 -0400
Received: from verdi.et.tudelft.nl ([130.161.38.158]:56704 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP id S264683AbTFQMXy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 08:23:54 -0400
Date: Tue, 17 Jun 2003 14:37:45 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
To: linux-kernel@vger.kernel.org
Cc: robn@verdi.et.tudelft.nl, Arjan van de Ven <arjanv@redhat.com>,
       Alan Cox <alan@redhat.com>
Subject: gcc-3.2.2 miscompiles kernel 2.4.* O_DIRECT code ?
Message-ID: <20030617123745.GA5717@verdi.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found out that O_DIRECT does not work correctly on 2.4 kernels
compiled with the RH gcc-3.2.2-5 on RH9.  It is working fine with
kernels compiled with the RH gcc-2.96-113 on RH 7.3.

The sympton is that read() only returns zeroes (as data).  No errors.
It happens with several 2.4 kernels I have tried, including 2.4.21-ac1.

I don't know if this is a RH9 gcc specific bug or if it is a generic
gcc3 problem. That's why I post here: to find out if more people
have seen this.

I also filed a bug in RH's bugzilla.  See this for more details:

	https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=97529


	greetings,
	Rob van Nieuwkerk
