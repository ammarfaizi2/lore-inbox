Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751748AbVLGSpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbVLGSpn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 13:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbVLGSpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 13:45:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28372 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751747AbVLGSpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 13:45:42 -0500
Date: Wed, 7 Dec 2005 13:45:34 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Mohamed El Dawy <msdawy@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Load-on-demand. How does the kernel locate the pages on secondary
 storage?
In-Reply-To: <afd776760512061938w7647b155r28a9eef8fdcfb640@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0512071345210.17172@cuia.boston.redhat.com>
References: <afd776760512061938w7647b155r28a9eef8fdcfb640@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Dec 2005, Mohamed El Dawy wrote:

>  Assume we have a process running, not all the pages of the process
> are in main memory. Some are swapped, and some are just not loaded
> yet.
> How does the kernel locate those pages on disk? Is there a pointer in
> the page table? or is there some place else? Any pointers to source
> code in the kernel would be greatly appreciated.

http://linux-mm.org/PageFaultHandling

-- 
All Rights Reversed
