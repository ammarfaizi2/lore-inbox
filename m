Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750746AbWFFCQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWFFCQN (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 22:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWFFCQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 22:16:12 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:41951 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750746AbWFFCQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 22:16:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=s7J4qFDPRdpbEjXVL7hEDlb9/dXXU+v+Y5RFJGQPvY2nCXHh3B9soQ0kA7YHyoH5jwUJmQaUduMPIaac9WMJ9w6NaXNP7ceUTGaiwBAA/79cuSxe8BUPPio1d/ZdDgWgvy7kwtf1BpoERWUqZLAh8QDc9vwM4jCN0k2u1/oPKaU=
Message-ID: <4484E562.3070401@gmail.com>
Date: Tue, 06 Jun 2006 11:16:02 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Jeremy Fitzhardinge <jeremy@goop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: State of resume for AHCI?
References: <447F23C2.8030802@goop.org> <447F3250.5070101@rtr.ca> <447F368F.2080305@rtr.ca>
In-Reply-To: <447F368F.2080305@rtr.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Mark Lord wrote:
>> The one-line "resume fix" (attached) *might* be all that you need.
>> This is in current Linus 2.6.17-rc*-git*
> 
> Oh.. yes, you'll have to switch to the ata_piix driver for this to work.
> So long as your AHCI is an Intel one, that will probably work fine.

Many notebooks don't allow changing between piix and ahci modes.  My 
notebook detects one piix interface and four ahci ports.  The piix 
interface is connected to the harddisk while one of the ahci ports is 
the hotswap bay.  So, my harddisk suspends and resumes fine but I can't 
use my dvd rom after suspend/resume.

-- 
tejun
