Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271201AbTHCPKd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 11:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271204AbTHCPKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 11:10:32 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:6095 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S271201AbTHCPKb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 11:10:31 -0400
Message-ID: <3F2D2686.308@terra.com.br>
Date: Sun, 03 Aug 2003 12:13:10 -0300
From: Marcelo Abreu <skewer@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: pt-br, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
Subject: Re: 2.6.0-test2-mm3
References: <3F2C7A03.6080204@terra.com.br> <20030803103628.GA2609@localhost>
In-Reply-To: <20030803103628.GA2609@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jose Luis Domingo Lopez wrote:
> Your mailer seems to have messed up newlines, so the patch (that I have
> no idea if its correct or not) won't apply ;-)


	The 4G patch has changed the 'ldt' member of mm_context_t, calling it 
'ldt_pages'. Patch from Raphael fixes fpu_system.h for correct 
compilation, but system won't boot with 'no387' parameter. So semantics 
must have been changed too.

	Maybe Ingo can review the effects of his changes on FPU emulation code.


	Marcelo Abreu


