Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUCFLOe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 06:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbUCFLOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 06:14:34 -0500
Received: from main.gmane.org ([80.91.224.249]:9906 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261648AbUCFLOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 06:14:30 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PATCH] UTF-8ifying the kernel source
Date: Sat, 06 Mar 2004 12:14:27 +0100
Message-ID: <yw1xu112b52k.fsf@kth.se>
References: <20040304100503.GA13970@havoc.gtf.org> <20040305232425.GA6239@havoc.gtf.org>
 <c2b2o0$cbp$1@terminus.zytor.com>
 <1078571331.963.3.camel@bip.parateam.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti211310a080-4136.bb.online.no
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:xtPU/fVJ93VMOhTfI95v0OIrRK4=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel <xavier.bestel@free.fr> writes:

> Le sam 06/03/2004 à 00:33, H. Peter Anvin a écrit :
>> Followup to:  <20040305232425.GA6239@havoc.gtf.org>
>> By author:    David Eger <eger@havoc.gtf.org>
>> In newsgroup: linux.dev.kernel
>> 
>> > The third patch concerns 8-bit characters embedded in C strings.
>> > These are almost always output to devfs or proc.  The characters used are
>> > the degrees symbol (for ppc temp. sensors) and mu (for micro-seconds).
>>
>> I would highly vote for making those UTF-8 unless it breaks protocol.
>
> ISO-8859-1 characters are mostly the same in UTF-8.

The 7-bit ones are the same.  The 8-bit ones are all different.

-- 
Måns Rullgård
mru@kth.se

