Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269398AbUIYTiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269398AbUIYTiX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 15:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269399AbUIYTiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 15:38:23 -0400
Received: from main.gmane.org ([80.91.229.2]:16049 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269398AbUIYTiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 15:38:21 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: OOM-killer killed everything
Date: Sat, 25 Sep 2004 18:12:50 +0600
Message-ID: <415560C2.1020602@ums.usu.ru>
References: <200409251326.13915.petkov@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dsa.physics.usu.ru
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: en-us, en
In-Reply-To: <200409251326.13915.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov wrote:
> Hi there,
> 
> I just started burning an audio cd with cdrecord, ran it as root because of 
> the SUID changes in 2.6.8 when this big bad guy by the name of OOM-killer 
> appeared and started killing everything :) I don't know whether the spurious 
> interrupt issue has something to do with it but according to what I've read 
> on lkml about it until now, it is supposed to be quite harmless. Sysinfo 
> + .config attached.
> 
> Regards,
> Boris.

Known bug. For the fix, see:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109309119620622&w=2

-- 
Alexander E. Patrakov

