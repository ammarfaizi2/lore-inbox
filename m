Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293508AbSCGLNN>; Thu, 7 Mar 2002 06:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310285AbSCGLNE>; Thu, 7 Mar 2002 06:13:04 -0500
Received: from idefix.linkvest.com ([194.209.53.99]:48657 "EHLO
	idefix.linkvest.com") by vger.kernel.org with ESMTP
	id <S293508AbSCGLMp>; Thu, 7 Mar 2002 06:12:45 -0500
Message-ID: <3C874B24.606@linkvest.com>
Date: Thu, 07 Mar 2002 12:12:36 +0100
From: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dominik Kubla <kubla@sciobyte.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rework of /proc/stat
In-Reply-To: <3C864F07.8050806@linkvest.com> <20020306194826.GB26866@duron.intern.kubla.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2002 11:12:37.0144 (UTC) FILETIME=[FCF9B980:01C1C5C8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>+        len += sprintf( page + len, "(%u,%u):(%u,%u,%u,%u,%u) ",
>>+                        stat->major, stat->minor,
>>+                        stat->io,
>>+                        stat->rio,
>>+                        stat->wio,
>>+                        stat->rblk,
>>+                        stat->wblk );
>>+    }
>>
>You are changing the order of the fields in /proc/stat. That breaks
>compatibility.
>
Thanks, you are right.
I'll change that.
-jec


