Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291245AbSBGTvz>; Thu, 7 Feb 2002 14:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291246AbSBGTvp>; Thu, 7 Feb 2002 14:51:45 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:640 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S291245AbSBGTv3>; Thu, 7 Feb 2002 14:51:29 -0500
Message-ID: <3C62DABF.5040303@nyc.rr.com>
Date: Thu, 07 Feb 2002 14:51:27 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [OOPS] Linux 2.5 and Parallel Port Zip 100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Loading the ppa module causes a kernel oops... apparently it causes some 
trouble for the interrupt handler.  It is a bit difficult to provide the 
  oops here since it freezes the entire machine, but I will try to break
my test box with this later today.

I am running 2.5 on an Intel PIII.

Affected kernels:
Linux 2.5.4-pre2  (and probably 2.5.3 and 2.5.4-pre1 since these both
                    have Evgeniy Polyakov's updates to "various SCSI
                    drivers to new locking" which includes ppa.c)

Who is maintaining the linux iomega stuff?

