Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262269AbVCBLip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbVCBLip (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 06:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbVCBLin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 06:38:43 -0500
Received: from smail4.alcatel.fr ([62.23.212.167]:3221 "EHLO smail4.alcatel.fr")
	by vger.kernel.org with ESMTP id S262269AbVCBLf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 06:35:59 -0500
Message-ID: <4225A4F6.2000106@linux-fr.org>
Date: Wed, 02 Mar 2005 12:35:18 +0100
From: Jean Delvare <khali@linux-fr.org>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.8a5) Gecko/20041222
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Ben Castricum <lk@bencastricum.nl>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Hancock <hancockr@shaw.ca>, khali@linux-fr.org
Subject: Re: 2.6.11-rc4 doubles CPU temperature
References: <007801c51ddf$271d95d0$0602a8c0@links>
In-Reply-To: <007801c51ddf$271d95d0$0602a8c0@links>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Alcanet-MTA-scanned-and-authorized: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

Ben Castricum wrote:
> For some weird reason, 2.6.11-rc4 up to the current BK tree about 
> doubles my CPU temperature from 20 degrees Celcius to 40 while
> everything else is unchanged (load/processes/config). The system
> does seem a bit more sluggish, but that may just be a feeling. 
> (...)
> I haven't got a clue on how to analyse this problem so I really appreciate
> any info or suggestions I get. Please help me.

If you have an Asus AS99127F chip, the value reported before in sysfs 
were not correct, the new ones are.

http://archives.andrew.net.au/lm-sensors/msg29730.html

40 degrees C is a fairly reasonable temperature for a CPU diode, there's 
nothing to be afraid of. At any rate it's more reasonable than the 
incredibly low 20 degrees C temperature you had before, as Robert 
Hancock noticed in an earlier post.

Hope that helps,
-- 
Jean Delvare
