Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVDDAWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVDDAWa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 20:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVDDAWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 20:22:30 -0400
Received: from zamok.crans.org ([138.231.136.6]:57316 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S261428AbVDDAW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 20:22:28 -0400
Message-ID: <425088C4.3040308@crans.org>
Date: Mon, 04 Apr 2005 02:22:28 +0200
From: =?ISO-8859-1?Q?Mathieu_B=E9rard?= <Mathieu.Berard@crans.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: 2.6.12-rc1-mm4 crash while mounting a reiserfs3 filesystem
References: <42500F5E.9090604@crans.org> <20050403145606.51ffeb72.akpm@osdl.org>
In-Reply-To: <20050403145606.51ffeb72.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> 
> 
> It appears that we might have jumped from flagged_taskfile into something
> at 0xdf6d1211, which is rather odd.
> 
> You have two different low-level IDE drivers configured.  Which one is
> driving that filesystem?  VIA or Promise?
> 

hdg is connected to my Promise PDC20268 (Ultra100 TX2)

-- 
Mathieu Bérard

