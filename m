Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbUDMEHB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 00:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbUDMEHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 00:07:01 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:15350 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263199AbUDMEG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 00:06:56 -0400
Message-ID: <407B6736.9090607@nortelnetworks.com>
Date: Tue, 13 Apr 2004 00:06:14 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: want to clarify powerpc assembly conventions in	head.S	and	entry.S
References: <4077A542.8030108@nortelnetworks.com>	 <1081591559.25144.174.camel@gaston>  <4078D42C.1020608@nortelnetworks.com>	 <1081661150.1380.183.camel@gaston>  <407AA848.2000008@nortelnetworks.com> <1081810459.1401.212.camel@gaston>
In-Reply-To: <1081810459.1401.212.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

> ret_from_syscall for syscalls, hash_page also has a different
> return to userland path, and load_up_{fpu,altivec} have their own
> retturn path.
> On ppc32 currently, the entry is almost always the same except for
> hash_page and load_up_{fpu,altivec}

Thanks, that's exactly the information I needed.

Chris
