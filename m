Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbTKNOQs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 09:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTKNOQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 09:16:48 -0500
Received: from port-212-202-185-245.reverse.qdsl-home.de ([212.202.185.245]:43927
	"EHLO gw.localnet") by vger.kernel.org with ESMTP id S262707AbTKNOQr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 09:16:47 -0500
Message-ID: <3FB4E3E2.3040203@trash.net>
Date: Fri, 14 Nov 2003 15:17:06 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.5-2
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.6] Nonsense-messages from iptables + co.
References: <20031114132054.GA646@merlin.emma.line.org>
In-Reply-To: <20031114132054.GA646@merlin.emma.line.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:

>Who the heck added these unhelpful
>
>"ipt_hook: happy cracking."
>
>messages to iptables/mangling/connection tracking code? There are three
>instances.
>
>If the kernel has got something to say, it should be clear what the
>kernel means, say, maximum <whatever> rate exceeded or something, not
>such junk like this.
>
>This is IMHO a MUST-FIX before 2.6.0.
>  
>

The bug that led to that message is already fixed. The message itself
might be stupid but is definitely not a must-fix item. Also, instead of
changing the message statistics should be added to conntrack etc. to
count unusual events instead of printing them to the console.

Best regards,
Patrick


