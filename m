Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262853AbTJEB5j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 21:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262855AbTJEB5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 21:57:39 -0400
Received: from [200.214.116.9] ([200.214.116.9]:15323 "HELO vialink.com.br")
	by vger.kernel.org with SMTP id S262853AbTJEB5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 21:57:38 -0400
Message-ID: <3F7F7A9E.1060204@vialink.com.br>
Date: Sat, 04 Oct 2003 22:57:50 -0300
From: Juan Carlos Castro y Castro <jcastro@vialink.com.br>
User-Agent: Mozilla/5.0 (Windows; U; Win98; pt-BR; rv:1.1) Gecko/20020826
X-Accept-Language: pt-BR,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel doesn't see USB ADSL modem - pegasus?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, it didn't work -- I inserted the following line in pegasus.h:

PEGASUS_DEV( "SpeedStream", VENDOR_SIEMENS, 0xe240,
DEFAULT_GPIO_RESET | PEGASUS_II )

Because that's what appeared in /proc/bus/usb/devices. But now, modprobe 
pegasus hangs (the process, not the machine). Also, any attemp to access 
/proc/bus/usb hangs the process. Kudzu hangs too. Now I reached the 
limits of my knowledge. :(

-- 
"I drank WHAT?" --Socrates


