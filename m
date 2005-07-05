Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVGESYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVGESYn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 14:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVGESYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 14:24:43 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:44490 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S261920AbVGESVM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 14:21:12 -0400
Message-ID: <42CACF8D.2060203@free.fr>
Date: Tue, 05 Jul 2005 20:21:01 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd and bad sectors
References: <42C6A12A.8030009@free.fr> <1120579233.23118.22.camel@localhost.localdomain>
In-Reply-To: <1120579233.23118.22.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Alan Cox wrote:
> On Sad, 2005-07-02 at 15:14, matthieu castet wrote:
> 
>>Also I was wondering if all the sector that ide-cd failed to read are 
>>bad sector, or if ide-cd failed to put the drive in a consistent state 
>>for reading the next sector after corrupted one.
> 
> 
> ide-cd wrongly errors all the sectors around an error, ide-scsi gets it
> right if the IDE firmware does. I sent Bartlomiej patches to fix that
> and I believe he accepted them
> 
thanks,

they don't seem to be in his tree : 
http://www.kernel.org/git/?p=linux%2Fkernel%2Fgit%2Fbart%2Fide-2.6.git&a=search&s=ide-cd 
:(

Matthieu
