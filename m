Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130692AbRCMLKu>; Tue, 13 Mar 2001 06:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130678AbRCMLKk>; Tue, 13 Mar 2001 06:10:40 -0500
Received: from zeus.kernel.org ([209.10.41.242]:22500 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130541AbRCMLKV>;
	Tue, 13 Mar 2001 06:10:21 -0500
Date: Tue, 13 Mar 2001 19:03:04 +0800
From: ³¯¤ý®i <cwz@aic.ee.ndhu.edu.tw>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About DC-315U scsi driver
Message-Id: <20010313190304.62fbf6c7.cwz@aic.ee.ndhu.edu.tw>
In-Reply-To: <20010312004401.H2697@garloff.casa-etp.nl>
In-Reply-To: <20010311163710.11a86b52.cwz@aic.ee.ndhu.edu.tw>
	<20010312004401.H2697@garloff.casa-etp.nl>
X-Mailer: Sylpheed version 0.4.9 (GTK+ 1.2.8; Linux 2.4.2-ac17; i686)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2001 00:44:01 +0100
Kurt Garloff <kurt@garloff.de> wrote:


> Anyway, you can use the patch from 1.32 to have the driver integrated in the
> 2.4 kernel and the use the version from Tekram. (I believe they distribute
> my version 1.27, but I didn't check fro quite some time.)
> I would like to hear your results.
> 




   Today I try to recompiler a new kernel with integrated driver. And burn a test
CDR. The errors are still alive.

   The Driver from Tekram only support 2.2.x;I think that I cannot use it with 
2.4.2,is right?

   And I finally understand the readme which you wrote.
(I cannot found README.tmscsim at beginning)
 I try to lower the syncspeed, and it still has no help(8Mhz,5Mhz...).

echo "0 0 0 y n n  n n n -2 5 " > /proc/scsi/dc395x_trm/0
                   ^=======>>if I lower syncspeed and not set the DsCn=no
the system would  halt.

   I have no idea about why it is. :(  Now burning CDR is a nightmare.

Best Regards,cwz
