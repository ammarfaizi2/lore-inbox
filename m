Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030691AbWKOQrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030691AbWKOQrk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030694AbWKOQrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:47:40 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:14000
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030691AbWKOQri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:47:38 -0500
Message-Id: <455B5305.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 15 Nov 2006 16:48:53 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: fix MTRR code
References: <455B3D8B.76E4.0078.0@novell.com>
 <p73ac2sd5jz.fsf@bingen.suse.de>
In-Reply-To: <p73ac2sd5jz.fsf@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I also got one reject in generic.c for
>
>-       if (base + size < 0x100) {
>+       if (base < 0x100) {
>
>but I hope that's ok

Hmm, not really - it applied cleanly on 2.6.19-rc5.

Jan
