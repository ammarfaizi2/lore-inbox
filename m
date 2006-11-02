Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752541AbWKBKy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbWKBKy1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 05:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752823AbWKBKy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 05:54:27 -0500
Received: from gwmail.nue.novell.com ([195.135.221.19]:10403 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1752541AbWKBKy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 05:54:26 -0500
Message-Id: <4549DCDB.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Thu, 02 Nov 2006 11:56:11 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: "Martin Lorenz" <martin@lorenz.eu.org>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc3: more DWARFs and strange messages
References: <20061028200151.GC5619@gimli> <p73hcxklfoy.fsf@verdi.suse.de>
 <20061031160815.GM27390@gimli> <454787AB.76E4.0078.0@novell.com>
 <20061031170320.GA6227@gimli>
In-Reply-To: <20061031170320.GA6227@gimli>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, another thing you could do is a sysrq-t with the increased
kstack= - this should encounter several kernel_thread()-s, and all
of them should exhibit the problem you were seeing. That output
could then be of help.

Thanks, Jan


