Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTFLLYU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 07:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264620AbTFLLYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 07:24:14 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:30427 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S263638AbTFLLYK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 07:24:10 -0400
Message-ID: <3EE86864.5070207@free.fr>
Date: Thu, 12 Jun 2003 13:47:48 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 timeline was RE: 2.4.21-rc7 ACPI broken
References: <3EE66C86.8090708@free.fr> <20030611211506.GD16164@fs.tum.de>
In-Reply-To: <20030611211506.GD16164@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Wed, Jun 11, 2003 at 01:40:54AM +0200, Eric Valette wrote:
> 
>>...
>>I would personnally suggest that you classify the things using the 
>>following filter :
>>	a) Server (SMP, SCSI, RAID, journaling filesystems, ...),
>>	b) laptop (ACPI, CPUFREQ, Software suspend, IDE power save,...),
>>	c) desktop (File system efficiency, new hardware support,...),
>>	d) all systems
>>...
> 
> 
> Why are journaling filesystems only for servers?
> Is file system efficiency not relevant on servers?

I was just making suggestions after a 30s thinking. Side comments, 
readding this mailling list, I had the impression that journaling and 
filesystem performance do not seem to mix well. Also on server, you have 
probably extra backup hardware and means (e.g RAID, DAT, DLT, ...)



> The important sections are more likely (ordered by priority):
> - bug fixes (e.g. aic7xxx)
> - support for additional hardware (e.g. ACPI update)
> - new features (e.g. XFS)

Personnaly, I dislike this approach as it as resulted in 2.4 being non 
usable for servers (SMP deadlocks, IO stalls, unresponsiveness for 
several seconds, ...) and laptop (ACPI)...

> The important thing is that this is inside a stable kernel series and an 
> update that makes things better for 100 people but makes things worse 
> for one person is IMHO bad since it's a regression for one person.

If 2.4 kernel is not usable without patching, It is far worse for me...


-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr

