Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269314AbUIYMZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269314AbUIYMZX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 08:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269315AbUIYMZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 08:25:22 -0400
Received: from mail.aknet.ru ([217.67.122.194]:33802 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S269314AbUIYMZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 08:25:19 -0400
Message-ID: <415563C7.8000701@aknet.ru>
Date: Sat, 25 Sep 2004 16:25:43 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: ESP corruption bug - what CPUs are affected?
References: <414C662D.5090607@aknet.ru> <20040918165932.GA15570@vana.vc.cvut.cz> <414C8924.1070701@aknet.ru> <20040918203529.GA4447@vana.vc.cvut.cz> <4151C949.1080807@aknet.ru> <20040922200228.GB11017@vana.vc.cvut.cz> <41530326.2050900@aknet.ru> <20040923180607.GA20678@vana.vc.cvut.cz> <4154853F.6070105@aknet.ru> <20040924214330.GD8151@vana.vc.cvut.cz> <20040925080426.GB12901@iram.es>
In-Reply-To: <20040925080426.GB12901@iram.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Gabriel Paubert wrote:
> Maybe I miss something, but it seems that lret (or retl)
> is not affected by this bug.
Petr Vandrovec says (he forgot to CC that
to LKML I think):
---
Looking at VMware's code it seems that RETF suffers from
this bug too...
---

I tested that - he is right, and Intel docs
make no sense as to not mentioning this.

