Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWEVITw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWEVITw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 04:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWEVITv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 04:19:51 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:54279 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1750808AbWEVITv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 04:19:51 -0400
Message-ID: <44717424.4020705@argo.co.il>
Date: Mon, 22 May 2006 11:19:48 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Michael Buesch <mb@bu3sch.de>
CC: Pau Garcia i Quiles <pgquiles@elpauer.org>, linux-kernel@vger.kernel.org
Subject: Re: [IDEA] Poor man's UPS
References: <200605212131.47860.pgquiles@elpauer.org> <20060521193803.GG8250@redhat.com> <200605212146.30342.mb@bu3sch.de>
In-Reply-To: <200605212146.30342.mb@bu3sch.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 May 2006 08:19:49.0818 (UTC) FILETIME=[7E7B11A0:01C67D78]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
>>  > The "continuous hibernation" is some kind of memory snapshots taken, say, 
>>  > every 5 minutes. The next time your system starts after a crash, it'd say "oh 
>>     
>
> You really want a system, which freezes for 10-20 seconds every 5 minutes,
> and thaws again when the image is written?
>   

The snapshot could be taken in the background, by marking all pages 
read-only, starting a thread to write them to disk, and continuing 
normal processing.

Such systems have been implemented in the past, see for example 
http://www.eros-os.org/.

-- 
error compiling committee.c: too many arguments to function

