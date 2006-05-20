Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWETBLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWETBLU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 21:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWETBLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 21:11:20 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:54963 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1751461AbWETBLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 21:11:19 -0400
Date: Fri, 19 May 2006 18:11:06 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: =?iso-8859-1?Q?=22D=F6hr=2C_Markus_ICC-H=22?= 
	<Markus.Doehr@siegenia-aubi.com>
cc: "'Peter Gordon'" <codergeek42@gmail.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: RE: replacing X Window System !
In-Reply-To: <FC7F4950D2B3B845901C3CE3A1CA6766333F93@mxnd200-9.si-aubi.siegenia-aubi.com>
Message-ID: <Pine.LNX.4.62.0605191801020.2828@qynat.qvtvafvgr.pbz>
References: <FC7F4950D2B3B845901C3CE3A1CA6766333F93@mxnd200-9.si-aubi.siegenia-aubi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 May 2006, "Döhr, Markus ICC-H" wrote:

> Date: Sat, 20 May 2006 02:57:55 +0200
> From: "\"Döhr, Markus ICC-H\"" <Markus.Doehr@siegenia-aubi.com>
> To: 'Peter Gordon' <codergeek42@gmail.com>
> Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
> Subject: RE: replacing X Window System !
> 
>>> Although one has to admit that working with remote X
>> terminals over a
>>> SSH/WAN/VPN-connection is far from usefull, [...]
>> You can tunnel just about anything X11 over SSH/VPN/etc.; even things
>> like a whole desktop GUI; not just plain X terminals.
>
> Did you actually do that? Starting Firefox over a 6 Mbit VPN takes about 3
> minutes on a FAST machine. That´s not acceptable - our users want (almost)
> immediate response to an application, to clicking and waiting 10 seconds
> until the app is doing something.

this is due to the latency, not the speed (X by default requires many 
round-trips to startup). There is an extention that greatly reduces the 
number of round-trips nessasary, I'm willing to bet this will make a huge 
difference for your startup. Unfortunantly I don't remember what this is.

however the huge delays on startup don't translate into a general slowdown 
once the application is started.

yes, this is an add-on, but the way that X evolves is for new 
functionality to be initially available as an add-on, and then move into 
the core distribution.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

