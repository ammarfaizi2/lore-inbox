Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWAaTUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWAaTUS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 14:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWAaTUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 14:20:18 -0500
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:25778 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1751299AbWAaTUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 14:20:16 -0500
Date: Tue, 31 Jan 2006 13:18:37 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Brian Twichell <tbrian@us.ibm.com>, Ray Bryant <raybry@mpdtxmail.amd.com>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
Message-ID: <15D75E814ADD9E4E6FCCD9E1@[10.1.1.4]>
In-Reply-To: <43DFB0D7.3070805@us.ibm.com>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
 <Pine.LNX.4.61.0601202020001.8821@goblin.wat.veritas.com>
 <43DAA3C9.9070105@us.ibm.com> <200601301246.27455.raybry@mpdtxmail.amd.com>
 <43DFB0D7.3070805@us.ibm.com>
X-Mailer: Mulberry/4.0.0b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, January 31, 2006 12:47:51 -0600 Brian Twichell
<tbrian@us.ibm.com> wrote:

>> Do you know if Dave's patch supports sharing of pte's for 2 MB pages on 
>> X86_64?
>>  
>> 
> I believe it does.  Dave, can you confirm ?

It shares pmd pages for hugepages, which I assume is what you're talking
about.

Dave McCracken

