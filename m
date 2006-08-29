Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWH2GIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWH2GIA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 02:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWH2GIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 02:08:00 -0400
Received: from mx1.suse.de ([195.135.220.2]:46754 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751237AbWH2GH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 02:07:59 -0400
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Why Semaphore Hardware-Dependent?
Date: Tue, 29 Aug 2006 08:07:40 +0200
User-Agent: KMail/1.9.3
Cc: Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>,
       Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       David Howells <dhowells@redhat.com>
References: <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <1156750249.3034.155.camel@laptopd505.fenrus.org> <44F395DE.10804@yahoo.com.au>
In-Reply-To: <44F395DE.10804@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608290807.40963.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> and chuck out the "crappy" rwsem fallback implementation

What is crappy with it?

I went with it because there were some serious concerns about
the complexity of the i386 rwsem code and so far nobody has complained
about them being too slow.

But yes rwsems could need some big cleanup.

-Andi


