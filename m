Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268680AbUIQK4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268680AbUIQK4m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 06:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268689AbUIQK4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 06:56:40 -0400
Received: from holomorphy.com ([207.189.100.168]:37547 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268680AbUIQKzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 06:55:54 -0400
Date: Fri, 17 Sep 2004 03:55:23 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: top hogs CPU in 2.6: kallsyms_lookup is very slow
Message-ID: <20040917105523.GL9106@holomorphy.com>
References: <200409161428.27425.vda@port.imtp.ilyichevsk.odessa.ua> <200409161457.08544.vda@port.imtp.ilyichevsk.odessa.ua> <20040916121747.GQ9106@holomorphy.com> <200409171201.15158.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409171201.15158.vda@port.imtp.ilyichevsk.odessa.ua>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 September 2004 15:17, William Lee Irwin III wrote:
>> Did the kallsyms patches reduce the cpu overhead from get_wchan()?

On Fri, Sep 17, 2004 at 12:01:15PM +0300, Denis Vlasenko wrote:
> Yes. top does not hog CPU anymore. It takes even a liitle bit *less*
> CPU than in 2.4 now.

Brilliant! Profile comparisons (merely booting the same kernels with
profile=2 or whatever shift you deem acceptable given that little RAM),
if feasible, would also be appreciated.

Thanks.


-- wli
