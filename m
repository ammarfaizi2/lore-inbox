Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264019AbUDQAP7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 20:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264020AbUDQAP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 20:15:59 -0400
Received: from f03m-9-140.d1.club-internet.fr ([212.194.56.140]:5124 "EHLO
	FriBiGateway.pastresbeau.net") by vger.kernel.org with ESMTP
	id S264019AbUDQAP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 20:15:58 -0400
Message-ID: <40807740.7060902@free.fr>
Date: Sat, 17 Apr 2004 02:16:00 +0200
From: PasTresBeau <pastresbeau@free.fr>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040410)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: nfs 2 over udp file corruption
References: <407FCF89.6070305@free.fr> <1082132424.2581.46.camel@lade.trondhjem.org>
In-Reply-To: <1082132424.2581.46.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Fri, 2004-04-16 at 05:20, PasTresBeau wrote:
> 
>>Copying a file over a nfs v2-udp mount
>>gets the file corrupted.. the command
>>exits saying "mv: closing <my_filename>: IO Error"
> 
> > Are you using the "soft" mount option?

yes, my fstab entry was :
defaults,nodev,rsize=8192,wsize=8192,soft

the problem disappeared when added ..,tcp,nfsvers=3 ;)

--
damien

