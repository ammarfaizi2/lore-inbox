Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422644AbWF0W0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422644AbWF0W0y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422683AbWF0W0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:26:53 -0400
Received: from mga03.intel.com ([143.182.124.21]:8224 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1422644AbWF0W0v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:26:51 -0400
X-IronPort-AV: i="4.06,184,1149490800"; 
   d="scan'208"; a="58284598:sNHT182387898"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] ia64: change usermode HZ to 250
Date: Tue, 27 Jun 2006 15:26:47 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A27F855@scsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ia64: change usermode HZ to 250
Thread-Index: AcaaNYFathJcIyT6Qsiafki1HSGtVgAAitnQ
From: "Luck, Tony" <tony.luck@intel.com>
To: <hawkes@sgi.com>, "Tony Luck" <tony.luck@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Cc: "Jack Steiner" <steiner@sgi.com>, "Dan Higgins" <djh@sgi.com>,
       "Jeremy Higdon" <jeremy@sgi.com>
X-OriginalArrivalTime: 27 Jun 2006 22:26:48.0561 (UTC) FILETIME=[C7AEDE10:01C69A38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -# define HZ 1024
> +# define HZ 250

Is every distribution just using the default 250? (How boring,
what't the use of CONFIG options if everyone makes the same choice).

No other architecture seems to want to be nice to applications,
I see "#define HZ 100" across most of them.  If this is going in,
it should fix all architectures.

Isn't the usual answer "applications should not include kernel
headers"?

-Tony
