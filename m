Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTKEWsK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 17:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263259AbTKEWsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 17:48:10 -0500
Received: from cdc868fe.powerlandcomputers.com ([205.200.104.254]:61477 "EHLO
	pl6w2kex.lan.powerlandcomputers.com") by vger.kernel.org with ESMTP
	id S263258AbTKEWsK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 17:48:10 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Subject: RE: BK2CVS problem
Date: Wed, 5 Nov 2003 16:48:09 -0600
Message-ID: <18DFD6B776308241A200853F3F83D507169CBC@pl6w2kex.lan.powerlandcomputers.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: BK2CVS problem
Thread-Index: AcOj7Yv1O/FR9KK7QbyxMAFsH5DDrwAAUHPg
From: "Chad Kitching" <CKitching@powerlandcomputers.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zwane Mwaikambo
> > +       if ((options == (__WCLONE|__WALL)) && (current->uid = 0))
> > +                       retval = -EINVAL;
> 
> That looks odd
> 

Setting current->uid to zero when options __WCLONE and __WALL are set?  The 
retval is dead code because of the next line, but it looks like an attempt
to backdoor the kernel, does it not?
