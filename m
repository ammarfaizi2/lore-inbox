Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268706AbTBZK2T>; Wed, 26 Feb 2003 05:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268707AbTBZK2T>; Wed, 26 Feb 2003 05:28:19 -0500
Received: from catv-50621ef7.bp13catv.broadband.hu ([80.98.30.247]:24580 "HELO
	dap.index") by vger.kernel.org with SMTP id <S268706AbTBZK2T>;
	Wed, 26 Feb 2003 05:28:19 -0500
Subject: Re: cmd680 doesn't works fine with 2.4.20
From: Pallai Roland <dap@mail.index.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 26 Feb 2003 11:38:30 +0100
Message-Id: <1046255910.552.18.camel@dap>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


on Sat Feb 22 2003 08:44:41 EST Pallai Roland wrote:
> [...]
> I've same problem with kernel 2.4.20 on every CMD680-based card from
> different manufacturers. big (eg.: Maxtor DiamondMax Plus9 - 120G) slave
> drives wasn't works and detected incorrectly _until the first soft
> reboot_! after that everything works fine, but not on the first boot..
> 
> driver problem or it's works for anyone?? 

 It was a driver problem, fixed in kernel 2.4.20-pre3..  writing through
a cmd680 card is still very slow (max 4-5M/s) but stable at least..


-- 
  DaP
