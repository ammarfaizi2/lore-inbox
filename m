Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269856AbTGKJcS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 05:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269857AbTGKJcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 05:32:18 -0400
Received: from village.ehouse.ru ([193.111.92.18]:61453 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S269856AbTGKJb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 05:31:59 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 898] New: Very HIGH File & VM system latencies and system stop responding while extracting big tar  archive file.
Date: Fri, 11 Jul 2003 13:46:39 +0400
User-Agent: KMail/1.5
References: <111930000.1057904059@[10.10.2.4]>
In-Reply-To: <111930000.1057904059@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307111346.39731.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

On Friday 11 July 2003 10:14, Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=898
>
>            Summary: Very HIGH File & VM system latencies and system stop
>                     responding while extracting big tar  archive file.
>     Kernel Version: 2.5.75
>             Status: NEW
>           Severity: high
>              Owner: bugme-janitors@lists.osdl.org
>          Submitter: bakhtiar@softhome.net
>
>
> Distribution:Slackware v7.1 : glibc v2.1.3
> Hardware Environment: P!!! 550 MHz, 256 MB RAM. HP Brio BA600

The same issues here with 2.5.7{4,5}. IO-intencive task got stuck in 'D'
state (bk,rsync,tar - it really doesn't matter). I think a have to get decoded
Alt-SysRq-T for this tasks next time. 

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
