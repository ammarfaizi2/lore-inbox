Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270277AbUJUEPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270277AbUJUEPW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 00:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270580AbUJUEOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 00:14:07 -0400
Received: from 209-128-98-078.BAYAREA.NET ([209.128.98.78]:10394 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S270460AbUJUELQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 00:11:16 -0400
Message-ID: <417736C0.8040102@zytor.com>
Date: Wed, 20 Oct 2004 21:10:40 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Michael Clark <michael@metaparadigm.com>
CC: Chris Friesen <cfriesen@nortelnetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <20041016062512.GA17971@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com> <20041017133537.GL7468@marowsky-bree.de> <cl6lfq$jlg$1@terminus.zytor.com> <4176DF84.4050401@nortelnetworks.com> <4176E001.1080104@zytor.com> <41772674.50403@metaparadigm.com>
In-Reply-To: <41772674.50403@metaparadigm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Clark wrote:
>>
>> Doing work twice can hardly be considered The Right Thing.
> 
> Optimisations that break documented interfaces and age old assumptions
> can hardly be considered The Right Thing :)

The whole point is that it doesn't break the *documented* interface.

	-hpa
