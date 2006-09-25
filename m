Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751641AbWIYEZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbWIYEZv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 00:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660AbWIYEZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 00:25:51 -0400
Received: from opersys.com ([64.40.108.71]:42762 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751604AbWIYEZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 00:25:50 -0400
Message-ID: <45175F28.3090109@opersys.com>
Date: Mon, 25 Sep 2006 00:46:32 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Richard J Moore <richardj_moore@uk.ibm.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
CC: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       "Frank Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Ingo Molnar <mingo@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       SystemTAP <systemtap@sources.redhat.com>,
       Satoshi Oshima <soshima@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       William Cohen <wcohen@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: Does this work? "dcprobes" an x86-hack simple djprobes-equivalent?
References: <45163D3D.4010108@opersys.com>
In-Reply-To: <45163D3D.4010108@opersys.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Slight binary typo ...

Karim Yaghmour wrote:
> Of course, this means hardwiring a multiplexing function at
> 0xCCCC,0xCCCCCCCC, if that makes any sense (offset 0xCCCCCCCC
> of code segment entry 7,099 of the LDT with an RPL of 1).

Actually 0xCCCC is code segment entry 6,553 of the LDT with an
RPL of 0.

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
