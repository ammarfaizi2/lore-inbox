Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWAJXL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWAJXL2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 18:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWAJXL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 18:11:28 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:9671 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751180AbWAJXL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 18:11:28 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
cc: Paulo Marques <pmarques@grupopie.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       tony.luck@intel.com, Systemtap <systemtap@sources.redhat.com>,
       Jim Keniston <jkenisto@us.ibm.com>
Subject: Re: [patch 1/2] [BUG]kallsyms_lookup_name should return the text addres 
In-reply-to: Your message of "Tue, 10 Jan 2006 13:07:37 -0800."
             <20060110130737.A14197@unix-os.sc.intel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 11 Jan 2006 10:11:26 +1100
Message-ID: <18641.1136934686@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keshavamurthy Anil S (on Tue, 10 Jan 2006 13:07:37 -0800) wrote:
>On Tue, Jan 10, 2006 at 08:45:02PM +0000, Paulo Marques wrote:
>> 
>> This conflicts with a similar patch from Keith Owens earlier this week.
>In fact I was the one who brought this issue to Keith and I missed seeing his
>patch on the mailing list.
>
>> I actually prefer Keith's version as it is the one which solves the bug 
>> by changing as least as possible the current behavior.
>That's fine, we can live with Keith's patch.
>As long as the bug is solved, I am happy a man:-)
>
>But my [patch 2/2] speeds up the lookup and that can go in, I think.
>Please ack that patch if you think so.

Your second patch changes the behaviour of kallsyms lookup w.r.t
duplicate symbols.

