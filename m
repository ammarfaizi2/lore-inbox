Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWJRBsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWJRBsL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 21:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWJRBsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 21:48:11 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:25520 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1750837AbWJRBsJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 21:48:09 -0400
Message-ID: <453586E7.7030404@cn.ibm.com>
Date: Wed, 18 Oct 2006 09:44:07 +0800
From: Yi CDL Yang <yyangcdl@cn.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Alan Modra <amodra@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, binutils@sourceware.org,
       bug-binutils@gnu.org
Subject: Re: 2.6.19-rc2 has ld error for ppc64
References: <4534BA77.6040400@cn.ibm.com> <20061017132936.GF20843@bubble.grove.modra.org>
In-Reply-To: <20061017132936.GF20843@bubble.grove.modra.org>
X-MIMETrack: Itemize by SMTP Server on D23M0037/23/M/IBM(Release 7.0HF124 | January 12, 2006) at
 10/18/2006 09:51:17,
	Serialize by Router on D23M0037/23/M/IBM(Release 7.0HF124 | January 12, 2006) at
 10/18/2006 09:51:19
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Modra 写道:
> On Tue, Oct 17, 2006 at 07:11:51PM +0800, Yi CDL Yang wrote:
>> On building 2.6.19-rc2 on ppc64, ld always reports such an error:
>>
>> ".text exceeds stub group size"
> 
> This is not an error.  It is just a warning that might help explain a
> later error.  If the linker doesn't give any errors then the warning
> may safely be ignored.
> 
Many warnings aren't a good thing, we should have a clean build, this 
patch should be good.

