Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261633AbTCLO6i>; Wed, 12 Mar 2003 09:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261293AbTCLO6i>; Wed, 12 Mar 2003 09:58:38 -0500
Received: from smtp.linuxsecurity.com ([209.11.107.5]:58117 "EHLO
	juggernaut.guardiandigital.com") by vger.kernel.org with ESMTP
	id <S261633AbTCLO6X>; Wed, 12 Mar 2003 09:58:23 -0500
Message-ID: <3E6F4D93.4010905@guardiandigital.com>
Date: Wed, 12 Mar 2003 10:09:07 -0500
From: Nick DeClario <nick@guardiandigital.com>
Organization: Guardian Digital, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel hanging at boot
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have this strange problem with the kernel hanging while it's being 
read from the hard drive at boot time.  It starts to read it then the 
system completely hangs at about 2/3 through loading.

I am running EnGarde Linux when this happens, however I have tried 
RedHat 8.0 as well.  With RedHat it won't let me even begin to boot and 
it complains there is not enough memory (1GB in the machine).  I am 
fairly certain both these issues are the same.

Originally I thought maybe I downloaded bad ISO images, but the MD5 sums 
matched.  Then I checked for a bad CDs, dumped them and the ISOs matched.

The hardware is an Intel SE7501WV2 motherboard with dual Xeon 
processors, an Adaptec 2010S with four hard drives configured in a RAID 
1 array and 1GB of ram.

I have tried playing around with a number of different BIOS settings and 
  haven't gotten anywhere.  This may possibly be a problem with the RAID 
controller since it boots both the EnGarde and RedHat installation 
kernels from the install CD's without any problems at all and both 
installations go through without issue.

Thanks,
	-Nick

