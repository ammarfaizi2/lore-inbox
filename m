Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264510AbTDPRuT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 13:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264509AbTDPRuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 13:50:19 -0400
Received: from smtp.hccnet.nl ([62.251.0.13]:20890 "EHLO smtp.hccnet.nl")
	by vger.kernel.org with ESMTP id S264507AbTDPRuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 13:50:17 -0400
Message-ID: <3E9D9AEA.2090705@hccnet.nl>
Date: Wed, 16 Apr 2003 20:03:22 +0200
From: Gert Vervoort <gert.vervoort@hccnet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mansfield <patmans@us.ibm.com>
CC: tconnors@astro.swin.edu.au, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.67: ppa driver & preempt == oops
References: <3E982AAC.3060606@hccnet.nl> <1050172083.2291.459.camel@localhost> <3E993C54.40805@hccnet.nl> <1050255133.733.6.camel@localhost> <3E99A1E4.30904@hccnet.nl> <20030415120000.A30422@beaverton.ibm.com> <3E9C6F10.10001@hccnet.nl> <20030415144051.A31514@beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>
>Can you dd to and from the media OK?
>  
>
Same effect as mount, now dd is stuck in the "D" state, dd if=/dev/sda 
of=/tmp/kw:

[root@viper root]# ps -ax |grep dd
  985 tty1     D      0:00 dd if /dev/sda of /tmp/kw
 1041 tty2     S      0:00 grep dd
[root@viper root]#


   Gert

