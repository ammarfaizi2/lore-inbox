Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263970AbUDFR7V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 13:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263983AbUDFR7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 13:59:21 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:12474 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263970AbUDFR7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 13:59:16 -0400
Message-ID: <4072EFEE.6050907@colorfullife.com>
Date: Tue, 06 Apr 2004 19:59:10 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@fenrus.demon.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan wrote:

>afaics all Intel and AMD cpus with more than say 32 or 64 TLB's are
>actually 64 bit capable.... so obviously you run a 64 bit kernel there. 
>(and amd64 even has that sweet CAM filter on the tlbs to mitigate the
>effect even if you run a 32 bit kernel)
>
Does AMD document how the CAM filter actually works? x86-64 writes into 
the 4th level page table during a context switch and if I understand the 
patent description correctly, this defeates the flush filter and forces 
a full flush during a context switch.

--
    Manfred

