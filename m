Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263897AbTETTSk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 15:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263900AbTETTSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 15:18:40 -0400
Received: from fmr02.intel.com ([192.55.52.25]:39398 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S263897AbTETTSh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 15:18:37 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: e100 driver
Date: Tue, 20 May 2003 12:31:34 -0700
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E010107D71E@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: e100 driver
Thread-Index: AcMedc6gNs7YOnQHSh24Az7yEj+/aQAkB7sA
From: "Feldman, Scott" <scott.feldman@intel.com>
To: =?iso-8859-1?Q?David_G=F3mez?= <david@pleyades.net>,
       "Hugo Mills" <hugo-lkml@carfax.org.uk>
Cc: "Linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 May 2003 19:31:35.0188 (UTC) FILETIME=[6CC8F540:01C31F06]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gómez [david@pleyades.net] wrote:
> Is there some known problem in 2.4.20 with the e100 driver? 
> I've been seen lately a lot of errors in my kernel logs, with 
> the messages:
> 
> <31>May 19 09:05:42 kernel: hw tcp v4 csum failed
> <31>May 19 09:11:11 kernel: icmp v4 hw csum failure
> 
> repeated several times. I've switched back to the eepro100 
> driver and the checksum errors messages seems to go away...

David/Hugo, can you try turning off Rx checksum offloading in e100?  Set the module parameter XsumRX=0 to turn it off.  Thanks.
-scott
