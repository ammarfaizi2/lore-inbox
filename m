Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264258AbSIQPO7>; Tue, 17 Sep 2002 11:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264260AbSIQPO7>; Tue, 17 Sep 2002 11:14:59 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:28926 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S264258AbSIQPO6>; Tue, 17 Sep 2002 11:14:58 -0400
Message-ID: <3D87488E.8070301@drugphish.ch>
Date: Tue, 17 Sep 2002 17:21:50 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Kirk Reiser <kirk@braille.uwo.ca>, Skip Ford <skip.ford@verizon.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.35 undefined reference to `wait_task_inactive'
References: <200209160644.g8G6iEvo006691@pool-141-150-241-241.delv.east.verizon.net> <x7sn08k7r0.fsf@speech.braille.uwo.ca> <3D87422B.3080300@drugphish.ch> <20020917110828.D23555@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>+#ifdef MODULE
>>          ACPI_MODULE_NAME    ("hwgpe")
>>+#endif
> 
> Btw, why not put the #ifdef in the header file that defines 
> ACPI_MODULE_NAME(x) instead of littering more #ifdefs around code?

Right, stupid me. With that I even catch those modules I didn't 
explicitly set to 'm' in the ACPI subtree. But I guess this is up to the 
Intel guys anyway. If they don't patch it by 2.5.36 I'll submit a clean 
patch myself.

Regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

