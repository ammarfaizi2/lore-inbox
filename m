Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285850AbSCFXaz>; Wed, 6 Mar 2002 18:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286263AbSCFXap>; Wed, 6 Mar 2002 18:30:45 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:22155 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S285850AbSCFXal>; Wed, 6 Mar 2002 18:30:41 -0500
Message-ID: <3C866369.93C1FF23@us.ibm.com>
Date: Wed, 06 Mar 2002 10:43:53 -0800
From: Mingming cao <cmm@us.ibm.com>
Organization: Linux Technology Center
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "\"jean-eric.cuendet\"jean-eric.cuendet"@linkvest.com,
        linux-kernel <linux-kernel@vger.kernel.org>, mail-lists@stev.org
Subject: Re:[PATCH]Rework of /proc/stat
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Stevenson wrote:

> Hi
> 
> would a patch like this not make more sense
> i picked it up on this list a while ago i cannot remember who wrote it


Thank for your attention and help on my disk io patch.  Here is the link
to the original post
http://marc.theaimsgroup.com/?l=linux-kernel&m=100570447604813&w=2.  I
re-submitted it a while ago against 2.4 kernels and 2.5.2 kernel.  You
can find patches related to disk io statistics at
http://lse.sourceforge.net/resource/diskio/diskio.html

> fixed it a bit and it does much the same except it alows you to have
> any number of block devices though it does not work with scsi properly yet

My disk io patch sufaced a NULL pointer bug hidden in SCSI mid-layer. 
Peter Wong first reported this problem and submitted a patch which fixed
this problem scsi layer. See his patch and discussion at
http://marc.theaimsgroup.com/?l=linux-kernel&m=101406625014323&w=2
 
What problem did you fixed?


Mingming Cao
IBM Linux Technology Center
503-578-5024  IBM T/L: 775-5024
cmm@us.ibm.com
http://www.ibm.com/linux/ltc

-- 
Mingming Cao
IBM Linux Technology Center
503-578-5024  IBM T/L: 775-5024
cmm@us.ibm.com
http://www.ibm.com/linux/ltc
