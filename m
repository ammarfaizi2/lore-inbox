Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264271AbUD0SNC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbUD0SNC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 14:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264269AbUD0SMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 14:12:52 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:42628 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264247AbUD0SLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 14:11:08 -0400
Message-ID: <408EA22C.4090408@nortelnetworks.com>
Date: Tue, 27 Apr 2004 14:10:52 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grzegorz Kulewski <kangur@polcom.net>
CC: Marc Boucher <marc@linuxant.com>, Adam Jaskiewicz <ajjaskie@mtu.edu>,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, torvalds@osdl.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <20040427165819.GA23961@valve.mbsi.ca> <408E9771.7020302@mtu.edu> <F55B44BB-9870-11D8-85DF-000A95BCAC26@linuxant.com> <408E9C59.2090502@nortelnetworks.com> <Pine.LNX.4.58.0404271950170.4424@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.58.0404271950170.4424@alpha.polcom.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Kulewski wrote:

> Maybe kernel should display warning only once per given licence or even 
> once per boot (who needs warning about tainting tainted kernel?)

I think that's a very good point.  If the kernel is already tainted, maybe we don't need to print 
out additional taint messages.

Chris
