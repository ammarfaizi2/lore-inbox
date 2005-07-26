Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbVGZVgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVGZVgd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 17:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVGZVeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 17:34:05 -0400
Received: from dvhart.com ([64.146.134.43]:33465 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262068AbVGZVd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 17:33:29 -0400
Date: Tue, 26 Jul 2005 14:33:25 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Badari Pulavarty <pbadari@us.ibm.com>, Rik van Riel <riel@redhat.com>,
       agl@us.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Memory pressure handling with iSCSI
Message-ID: <148380000.1122413605@flay>
In-Reply-To: <1122411949.6433.50.camel@dyn9047017102.beaverton.ibm.com>
References: <1122399331.6433.29.camel@dyn9047017102.beaverton.ibm.com> <Pine.LNX.4.61.0507261659250.1786@chimarrao.boston.redhat.com> <1122411949.6433.50.camel@dyn9047017102.beaverton.ibm.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > After KS & OLS discussions about memory pressure, I wanted to re-do
>> > iSCSI testing with "dd"s to see if we are throttling writes.  
>> 
>> Could you also try with shared writable mmap, to see if that
>> works ok or triggers a deadlock ?
> 
> 
> I can, but lets finish addressing one issue at a time. Last time,
> I changed too many things at the same time and got no where :(

Adam is working that one, but not over iSCSI.

M.

