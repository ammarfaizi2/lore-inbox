Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbULXOFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbULXOFt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 09:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbULXOFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 09:05:49 -0500
Received: from pcsmail.patni.com ([203.124.139.197]:50585 "EHLO
	pcsmail.patni.com") by vger.kernel.org with ESMTP id S261372AbULXOFl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 09:05:41 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Pseudo Driver hangs :b_elv_sequence ?SUSE 8.0 SP3
Date: Fri, 24 Dec 2004 19:35:39 +0530
Message-ID: <374639AB1012AA4C840022842AA95BC203C70374@ruby.patni.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: What's wrong with Documentation/DocBook/kernel-api.tmpl? (was Re: Something wrong when transform Documentation/DocBook/*.tmpl into pdf)
Thread-Index: AcTpr8DiPj5xQBunRsqzO3hhC3fOvAAcxhuwAAQgf0A=
From: "Kotian, Deepak" <Deepak.Kotian@patni.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this POST, I am getting a response from SUSE.

Thanks and Regard
Deepak


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Kotian, Deepak
Sent: Friday, December 24, 2004 4:27 AM
To: linux-kernel@vger.kernel.org
Subject: Pseudo Driver hangs :b_elv_sequence ?SUSE 8.0 SP3
Importance: High


Hi,

I saw a response from you on  b_elv_sequence over here.
http://www.uwsg.iu.edu/hypermail/linux/kernel/0301.3/0472.html

I have observed a similar problem in 2.4.21-138 kernel which comes along 
with SUSE 8.0 SP3. 

This is mainly for SUSE. I presume, SUSE folks are active on this forum and would respond immediately.Please excuse others, sorry.

In Our pseudo block driver a Defect occurs only when read is done from urandom device & 
write to raw device. It basically hangs in kiobuf module.

We are using the buffer_head structure.

We have found by trial and error and looking the source at of raid and md devices that if b_elv_sequence parameter is set to zero, it is OK and our driver does not have a problem.
On looking at the site,we found that you are aware of it. Could you please elaborate.

Question:
 Please let us know your views on the b_elv_sequence and reason to set it to zero. 
 We need to justify whether our fix is correct.

Also, this is not there SLES 9.0 with kernel 2.6 as buffer head concept is gone.
But is the functionality mapped of this flag mapped somewhere in 2.6 or it is not
needed. Anyone here is aware of it.

P.S.
I have posted on SUSE support, not sure when I get response after internal
processing. As it is very urgent for me. I am posting it here as well.

Thanks and Regards
Deepak
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
