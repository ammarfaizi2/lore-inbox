Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbUKNNZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbUKNNZm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 08:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbUKNNZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 08:25:42 -0500
Received: from mail8.spymac.net ([195.225.149.8]:36563 "EHLO mail8")
	by vger.kernel.org with ESMTP id S261298AbUKNNZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 08:25:36 -0500
Message-ID: <41976AE0.5090903@spymac.com>
Date: Sun, 14 Nov 2004 15:25:36 +0100
From: Gunther Persoons <gunther_persoons@spymac.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041113)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
References: <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <41951380.2080801@spymac.com> <20041112201936.GA15133@elte.hu> <41961C03.10607@spymac.com> <20041114124932.GB11042@elte.hu>
In-Reply-To: <20041114124932.GB11042@elte.hu>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>* Gunther Persoons <gunther_persoons@spymac.com> wrote:
>
>  
>
>>As i thought the init scripts were my problem. But i have an other
>>question. I recently started to use NFS. But with the mainline kernel
>>cpu usage is 100%, and when i look in top si shows bewteen 40 and 60%
>>cpu usage. With your kernel si is 0%, but ksoftriqd/0 shows around 38%
>>cpu usage and total cpu usage is around 52%. Is this normal? on my
>>server cpu usage is 2% but it uses a intel network card. My laptop is
>>using a wireless pcmcia card (cisco).
>>    
>>
>
>normally the RT kernel has higher system overhead (all IRQ traffic goes
>to separate thread contexts, involving context-switching, etc.) so a
>_reduction_ in system overhead looks a bit strange. Is there a
>difference in performance?
>
>	Ingo
>
>  
>
With the mainline kernel i get speeds around 600-700kb/s and with the RT 
kernel i get speeds around 550kb/s. No other differnces except the cpu 
usage and that the RT kernel feels much more responsive.
