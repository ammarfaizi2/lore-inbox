Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290769AbSBOUUC>; Fri, 15 Feb 2002 15:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290771AbSBOUT4>; Fri, 15 Feb 2002 15:19:56 -0500
Received: from firewall.oeone.com ([216.191.248.101]:44300 "HELO
	mail.oeone.com") by vger.kernel.org with SMTP id <S290769AbSBOUTt>;
	Fri, 15 Feb 2002 15:19:49 -0500
Message-ID: <3C6D6FA4.90502@oeone.com>
Date: Fri, 15 Feb 2002 15:29:24 -0500
From: Masoud Sharbiani <masouds@oeone.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011209
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ro0tSiEgE <ro0tsiege@bjstuff.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ALSA modules
In-Reply-To: <005a01c1b65a$41e393f0$ed00000a@citrix.bjstuff.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Usually, if one driver detects the supported hardware, it'll grab the 
resources and would control the hardware afterwards, so If your hardware 
is supported by normal kernel sound drivers, ALSA will refuse to load 
because IRQ and IO Addr of your sound hardware is registered to normal 
 kernel driver.
Cheers,
Masoud

Ro0tSiEgE wrote:

>If norm. kernel sound modules are compiled in, and ALSA is compiled as
>modules, can ALSA still work? And if so, how?
>
>Thanks
>


