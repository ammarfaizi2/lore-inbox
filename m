Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265862AbUA1GHA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 01:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265860AbUA1GHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 01:07:00 -0500
Received: from palrel11.hp.com ([156.153.255.246]:41653 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S265631AbUA1GG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 01:06:58 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16407.20861.415243.849317@napali.hpl.hp.com>
Date: Tue, 27 Jan 2004 22:06:53 -0800
To: Paul Mackerras <paulus@samba.org>
Cc: davidm@hpl.hp.com, Andrew Morton <akpm@osdl.org>,
       Jes Sorensen <jes@trained-monkey.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [patch] 2.6.1-mm5 compile do not use shared extable code for
 ia64
In-Reply-To: <16406.63734.400759.452955@cargo.ozlabs.ibm.com>
References: <E1Aiuv7-0001cS-00@jaguar.mkp.net>
	<20040120090004.48995f2a.akpm@osdl.org>
	<16401.57298.175645.749468@napali.hpl.hp.com>
	<16402.19894.686335.695215@cargo.ozlabs.ibm.com>
	<16405.41953.344071.456754@napali.hpl.hp.com>
	<16406.10170.911012.262682@cargo.ozlabs.ibm.com>
	<16406.36741.510353.456578@napali.hpl.hp.com>
	<16406.63734.400759.452955@cargo.ozlabs.ibm.com>
X-Mailer: VM 7.17 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 28 Jan 2004 10:49:10 +1100, Paul Mackerras <paulus@samba.org> said:

  Paul> I really don't like the uglification of lib/extable.c.

I disagree about this being an uglification.  But beauty is obviously
in the eye of the beholder...

Anyhow, you clearly feel _much_ stronger about this particular issue
than I do and I haven't heard much from Andrew, so I'll make a local
version of sort_extable() for now.  If someone cares about
resurrecting a generic version, they can do that later on.

	--david
