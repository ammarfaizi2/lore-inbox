Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268498AbUHYUS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268498AbUHYUS6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268589AbUHYUS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:18:58 -0400
Received: from mail.tmr.com ([216.238.38.203]:5126 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S268498AbUHYURf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:17:35 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Linux 2.6.9-rc1
Date: Wed, 25 Aug 2004 16:18:09 -0400
Organization: TMR Associates, Inc
Message-ID: <cgirou$2ju$1@gatekeeper.tmr.com>
References: <20040824184245.GE5414@waste.org><Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org> <Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1093464670 2686 192.168.12.100 (25 Aug 2004 20:11:10 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 24 Aug 2004, Matt Mackall wrote:
> 
>>Phew, I was worried about that. Can I get a ruling on how you intend
>>to handle a x.y.z.1 to x.y.z.2 transition? I've got a tool that I'm
>>looking to unbreak. My preference would be for all x.y.z.n patches to
>>be relative to x.y.z.
> 
> 
> Hmm.. I have no strong preferences. There _is_ obviously a well-defined 
> ordering from x.y.z.1 -> x.y.z.2 (unlike the -rcX releases that don't have 
> any ordering wrt the bugfixes), so either interdiffs or whole new full 
> diffs are totally "logical". We just have to chose one way or the other, 
> and I don't actually much care.
> 
> Any reason for your preference? 

It should work like a bk, so two kinds of logic aren't needed.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
