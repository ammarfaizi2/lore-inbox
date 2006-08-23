Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbWHWRsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbWHWRsd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 13:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbWHWRsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 13:48:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:24438 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965033AbWHWRsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 13:48:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VJMuUjzsjseePAa6bAqbljfj8oDpjdKcEtWzMymxrbPBQp+J3VxOEF3OeI31CXRA6C2vkV7jsdYdYCcVysAsqwnxcaA/J/TPDdYYsAgj0WtAk6pAjR6A+qe1Os3Jcre3bw7CXYDm8dwkk1tbp3wGBgD6/WZv/ld+EMrjNFXd9Us=
Message-ID: <44EC94A9.4010903@gmail.com>
Date: Thu, 24 Aug 2006 02:47:21 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Andre Tomt <andre@tomt.net>
CC: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: Hardware vs. Software Raid Speed
References: <44EBFB3E.8070905@perkel.com> <44EC02FD.7050207@tomt.net>
In-Reply-To: <44EC02FD.7050207@tomt.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Tomt wrote:
> Marc Perkel wrote:
>> Running Linux on an AMD AM2 nVidia chip ser that supports Raid 0 
>> striping on the motherboard. Just wondering if hardware raid (SATA2) 

SATA2 has nothing to do with hardware RAID.

>> is going to be faster that software raid and why?
> 
> Beeing a consumer type board (AM2), the "raid on the motherboard" is in 
> 99.999% of the cases just software raid implemented in their Windows 
> drivers, a bootup setup screen plus some BIOS magic to get the OS booting.

And, yeah, they're all software RAID.  Also, there isn't much to be 
gained from making RAID0/1 hardware.  The software overhead isn't that 
big.  For RAID5, having XOR done in hardware helps.

-- 
tejun
