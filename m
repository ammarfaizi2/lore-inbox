Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265266AbTLLPzP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 10:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265267AbTLLPzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 10:55:14 -0500
Received: from multiserv.relex.ru ([213.24.247.63]:25227 "EHLO
	mail.techsupp.relex.ru") by vger.kernel.org with ESMTP
	id S265266AbTLLPzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 10:55:10 -0500
From: Yaroslav Rastrigin <yarick@relex.ru>
Organization: RELEX Inc.
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0-test11: 3Com PCI 3c556B not working
Date: Fri, 12 Dec 2003 18:53:31 +0300
User-Agent: KMail/1.5.94
References: <200312121308.51306.andrew@walrond.org>
In-Reply-To: <200312121308.51306.andrew@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312121853.32975.yarick@relex.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !
On Friday 12 December 2003 16:08, Andrew Walrond wrote:
> Another problem with 2.6 on my thinkpad. Worked fine with 2.4
>
> Dmesg gives
>
> 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> 0000:00:03.0: 3Com PCI 3c556B Laptop Hurricane at 0x1400. Vers LK1.1.19
> PCI: Setting latency timer of device 0000:00:03.0 to 64
>   ***WARNING*** No MII transceivers found!
>
> I've got ACPI enabled; Might this be ACPI/interrupt  related?
bugzilla bug number 1188. 
It's ACPI-related, without ACPI this card works fine.
Btw, similar symptoms are described regularly on this list, with 
Vortex/Boomerang card. Nobody was/is able to help (yet) ?
>
> Andrew Walrond
>
> -

-- 
With all the best, yarick at relex dot ru.
