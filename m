Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWI3PEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWI3PEN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 11:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWI3PEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 11:04:13 -0400
Received: from mail.suse.de ([195.135.220.2]:40403 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751022AbWI3PEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 11:04:12 -0400
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: How is Code in do_sys_settimeofday() safe in case of SMP and Nest Kernel Path?
Date: Sat, 30 Sep 2006 17:03:45 +0200
User-Agent: KMail/1.9.3
Cc: Dong Feng <middle.fengdong@gmail.com>,
       Christoph Lameter <clameter@sgi.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Paul Mackerras <paulus@samba.org>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org
References: <a2ebde260609290733m207780f0t8601e04fcf64f0a6@mail.gmail.com> <a2ebde260609290916j3a3deb9g33434ca5d93e7a84@mail.gmail.com> <451E8143.5030300@yahoo.com.au>
In-Reply-To: <451E8143.5030300@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609301703.45364.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Did you get to the bottom of this yet? It looks like you're right,
> and I suggest a seqlock might be a good option.

It basically doesn't matter because nobody changes the time zone after boot.

-Andi
