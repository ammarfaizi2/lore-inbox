Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268861AbUJEG5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268861AbUJEG5Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 02:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268868AbUJEG5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 02:57:24 -0400
Received: from [217.222.53.238] ([217.222.53.238]:30600 "EHLO mail.gts.it")
	by vger.kernel.org with ESMTP id S268861AbUJEG5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 02:57:19 -0400
Message-ID: <41624598.6030509@gts.it>
Date: Tue, 05 Oct 2004 08:56:24 +0200
From: Stefano Rivoir <s.rivoir@gts.it>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: gww@btinternet.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm2
References: <20041004020207.4f168876.akpm@osdl.org>	<4161462A.5040806@gts.it>	<20041004121805.2bffcd99.akpm@osdl.org>	<4161BCCB.4080302@btinternet.com>	<20041004143253.50a82050.akpm@osdl.org> <20041004143953.10e6d764.akpm@osdl.org>
In-Reply-To: <20041004143953.10e6d764.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> 
>>Could you try this patch?  It'll locate the bug for us.

OK, applying all of the attached patches, the whole thing works (so, 
preemp_count fix, and preempt_disable/enable around those two #defines 
w/smp_processor_id).

Thank you all.

-- 
Stefano RIVOIR

