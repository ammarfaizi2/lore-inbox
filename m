Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbUK2W4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbUK2W4P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbUK2Wye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:54:34 -0500
Received: from mail.dnm.gov.ar ([200.55.54.66]:7328 "EHLO mail.dnm.gov.ar")
	by vger.kernel.org with ESMTP id S261850AbUK2Wtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:49:35 -0500
Message-ID: <41ABA80E.5040005@migraciones.gov.ar>
Date: Mon, 29 Nov 2004 19:51:58 -0300
From: Javier Villavicencio <javierv@migraciones.gov.ar>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: no entropy and no output at /dev/random  (quick question)
References: <41A7EDA1.5000609@migraciones.gov.ar> <Pine.LNX.4.53.0411272019350.27610@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411272019350.27610@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>I have a server that runs kernel 2.6.9, some web and monitoring
>>services, it's connected to two different networks with two different
>>network cards, and somehow a php developer discovered that /dev/random
>>wasn't giving any entropy to him (O_O) so i checked it out...
>>[...]
>>As you may see my only sources of entropy where the timer, eth0, eth1
>>and the DAC960.
> 
> 
> I doubt that timer and eth* are a non-predictable source. As such, they should
> not contribute to the entropy. Better is the keyboard and/or mouse. SSH traffic
> is network traffic, and if you send it to a network card, you can expect an
> interrupt at <time>... prdictable.
> 
> 
> Jan Engelhardt
Hmm you got it wrong, I'm saying that my only "interrupt generating 
hardware" was NOT contributing to the entropy. I mean, the timer (OF 
COURSE NOT) and the NICs (same) but why don't the DAC960???

-- 

       Javier Villavicencio
      Administrador/Consultor
Direccion Nacional de Migraciones
      Ministerio del Interior
       Republica Argentina
