Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290849AbSARWOS>; Fri, 18 Jan 2002 17:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290852AbSARWOK>; Fri, 18 Jan 2002 17:14:10 -0500
Received: from host155.209-113-146.oem.net ([209.113.146.155]:51190 "EHLO
	tibook.netx4.com") by vger.kernel.org with ESMTP id <S290849AbSARWNx>;
	Fri, 18 Jan 2002 17:13:53 -0500
Message-ID: <3C489DF4.5010900@embeddededge.com>
Date: Fri, 18 Jan 2002 17:13:08 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.11-pre6-ben0 ppc; en-US; 0.8) Gecko/20010419
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: pci_alloc_consistent from interrupt == BAD
In-Reply-To: <20020118130209.J14725@altus.drgw.net> <3C4875DB.9080402@embeddededge.com> <20020118.123221.85715153.davem@redhat.com> <20020118212949.H2059@flint.arm.linux.org.uk> <3C4897BD.1080503@embeddededge.com> <20020118215515.K2059@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:


> I refer you to your nearest function prototype for pte_alloc_one()
> rather than alloc_pages().

Oooo...thanks.  I guess I'll be adding the flag into pte_alloc as well
here in just a few minutes.  We'll see if that flies.  Everything prior
to this seems capable of handling the error if it doesn't succeed.

Thanks.


	-- Dan



