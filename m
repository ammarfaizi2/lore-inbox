Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVGZVN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVGZVN1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 17:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVGZVI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 17:08:28 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:10217 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262058AbVGZVGD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 17:06:03 -0400
Subject: Re: Memory pressure handling with iSCSI
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Rik van Riel <riel@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0507261659250.1786@chimarrao.boston.redhat.com>
References: <1122399331.6433.29.camel@dyn9047017102.beaverton.ibm.com>
	 <Pine.LNX.4.61.0507261659250.1786@chimarrao.boston.redhat.com>
Content-Type: text/plain
Date: Tue, 26 Jul 2005 14:05:49 -0700
Message-Id: <1122411949.6433.50.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-26 at 16:59 -0400, Rik van Riel wrote:
> On Tue, 26 Jul 2005, Badari Pulavarty wrote:
> 
> > After KS & OLS discussions about memory pressure, I wanted to re-do
> > iSCSI testing with "dd"s to see if we are throttling writes.  
> 
> Could you also try with shared writable mmap, to see if that
> works ok or triggers a deadlock ?


I can, but lets finish addressing one issue at a time. Last time,
I changed too many things at the same time and got no where :(

Thanks,
Badari

