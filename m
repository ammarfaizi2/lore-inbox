Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbWECIYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbWECIYg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 04:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbWECIYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 04:24:36 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:5912
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965024AbWECIYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 04:24:36 -0400
Message-Id: <4458851B.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Wed, 03 May 2006 10:25:31 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andy Whitcroft" <apw@shadowen.org>, "Andi Kleen" <ak@suse.de>
Cc: "Martin Bligh" <mbligh@google.com>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc2-mm1
References: <4450F5AD.9030200@google.com> <200605030849.44893.ak@suse.de> <4458730F.76E4.0078.0@novell.com> <200605030938.37967.ak@suse.de> <445865F7.1010208@shadowen.org>
In-Reply-To: <445865F7.1010208@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Heh, happy to do the testing.  Just to make sure I am doing the right
>thing, you want an entire stack frame dropped out in the case that
>SS/RSP are 0; so we get the RIP.

Just decrement the indices in the previous printk() by one each, i.e. ranging from -1 to -5.

Jan
