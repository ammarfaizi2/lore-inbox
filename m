Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265019AbTFRAH3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 20:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265020AbTFRAH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 20:07:29 -0400
Received: from fmr02.intel.com ([192.55.52.25]:31980 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S265019AbTFRAH2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 20:07:28 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [BK PATCH] 2.4 ACPI update
Date: Tue, 17 Jun 2003 17:21:21 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A84725A2F6@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BK PATCH] 2.4 ACPI update
Thread-Index: AcM1JmPOoFth9MqOR5qZDNP5ACBOdQAAwQ5w
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: "lkml" <linux-kernel@vger.kernel.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
X-OriginalArrivalTime: 18 Jun 2003 00:21:21.0679 (UTC) FILETIME=[8B81F1F0:01C3352F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Marcelo Tosatti [mailto:marcelo@conectiva.com.br] 
> Andrew,
> 
> I've changed my mind with respect to the ACPI merge in 2.4.22.
> 
> I'm willing to do it in .22 timeline.
> 
> I feel its better if we do the merge in separate parts, not in a huge
> patch.
> 
> What you think ?

Hi Marcelo,

Great!

I've been maintaining the ACPI branch in a bk tree for the past year, so
there are 100+ changesets nicely commented. Just doing a bk pull from
that would be the best way to maintain checkin comments. bk pull
http://linux-acpi.bkbits.net/linux-2.4-acpi .

I can also export the changesets if you'd like to review them, but they
won't apply cleanly to the tip, since they originally were against a
much older version.

Another option would be to take the raw .diff and re-carve it by files
modified - the arch/i386 changes, the interpreter changes, the old ospm
removal, the new ospm addition, all the headers moving to include/acpi.
I'm certainly willing to do that but that would lose the changelogs and
patch attributions.

Thanks -- Regards -- Andy
