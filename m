Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265437AbTLKUeS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 15:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265462AbTLKUeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 15:34:17 -0500
Received: from madness.at ([213.153.61.104]:29707 "EHLO cronos.madness.at")
	by vger.kernel.org with ESMTP id S265437AbTLKUeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 15:34:14 -0500
Message-ID: <3FD8D4D3.5010609@madness.at>
Date: Thu, 11 Dec 2003 21:34:27 +0100
From: Stefan Kaltenbrunner <mm-mailinglist@madness.at>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6a) Gecko/20031028
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nelsonis@earthlink.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Any known issues with MPT SCSI?
References: <3FD73C61.80708@earthlink.net>
In-Reply-To: <3FD73C61.80708@earthlink.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian S. Nelson wrote:

> I'm running some Dell 1750s with a moderately customized 2.4.20 kernel,  
> it has a couple of newer drivers but it's fairly standard.   I have 3 
> identical systems that are turning up ext3 corruption fairly regularly.  
> They are using the MPT/53c1030 SCSI.  2 of the 3 reported log corruption 
> on a boot and mounted the root filesystem in read only.  The other is 
> spitting

FWIW: we have more than a dozen of IBM x335/345 maschines using this 
controller (using 2.4.22 and 2.4.23), and most of these server do have 
_significant_ IO-Load at times . Whe have not yet encountered anything 
near a corrupted filesystem although the controllers itself do "feel" 
quite slow.



Stefan

