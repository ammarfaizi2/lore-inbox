Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030447AbVIJGNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbVIJGNI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 02:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030497AbVIJGNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 02:13:08 -0400
Received: from ns2.suse.de ([195.135.220.15]:55994 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030447AbVIJGNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 02:13:07 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] [PATCH] allow CONFIG_FRAME_POINTER for x86-64
Date: Sat, 10 Sep 2005 08:12:54 +0200
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, Alexander Nyberg <alexn@telia.com>,
       hugh@veritas.com, JBeulich@novell.com, linux-kernel@vger.kernel.org
References: <43207D28020000780002451E@emea1-mh.id2.novell.com> <20050909171929.GA4155@localhost.localdomain> <20050909221320.6b53a030.akpm@osdl.org>
In-Reply-To: <20050909221320.6b53a030.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509100812.55384.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 September 2005 07:13, Andrew Morton wrote:

> show_trace() uses print_context_stack(), but show_stack() just does a
> dump-everything.  I wondered why the CONFIG_FRAME_POINTER oops traces were
> still so crappy.   TIA ;)

It's a good thing - it wouldn't have any chance to get beyond the exception
frame.

-Andi

