Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbTJXKQh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 06:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbTJXKQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 06:16:37 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:29867 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261914AbTJXKQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 06:16:36 -0400
Message-Id: <200310241010.MAA29796@fire.malware.de>
Date: Fri, 24 Oct 2003 12:12:00 +0200
From: malware@t-online.de (Michael Mueller)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: mj@ucw.cz
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.4] PCI chipset Opti Viper M/N+
References: <200310240956.h9O9uDK27733@winbloz.malware.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: ZZtx0wZTQe0GLtHaE8CLxytgoLBrZgHwy-NdBBAaUuyFlrXuHK2FZs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin and linux-kernel readers,

receiving my previous mail myself did give me another view to it and now
I am curious why it did work that fine with following typo present:
> +       val |= newval << (3*(pirq*1));

it should read:
   val |= newval << (3*(pirq-1));

With this changed it still works with the PCMCIA card, but I still need
to gain access to a CardBus card to test it with.


Michael

-- 
Linux@TekXpress
http://www-users.rwth-aachen.de/Michael.Mueller4/tekxp/tekxp.html
