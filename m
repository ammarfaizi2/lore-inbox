Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262879AbTC0Exe>; Wed, 26 Mar 2003 23:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262881AbTC0Exe>; Wed, 26 Mar 2003 23:53:34 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:33260 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S262879AbTC0Exd>; Wed, 26 Mar 2003 23:53:33 -0500
Message-ID: <3E82866A.1000704@blue-labs.org>
Date: Thu, 27 Mar 2003 00:04:42 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030320
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: nit picking UDF
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.1 build 917; timestamp 2003-03-27 05:04:46, message serial number 842239
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI: (supports S0 S1 S4 S4bios S5)
You didn't specify the type of your ufs filesystem

mount -t ufs -o 
ufstype=sun|sunx86|44bsd|old|hp|nextstep|netxstep-cd|openstep ...

 >>>WARNING<<< Wrong ufstype may corrupt your filesystem, default is 
ufstype=old
ufs_read_super: bad magic number
UDF-fs DEBUG fs/udf/lowlevel.c:65:udf_get_last_session: 
CDROMMULTISESSION not supported: rc=-25
UDF-fs DEBUG fs/udf/super.c:1472:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:460:udf_vrs: Starting at sector 16 (2048 
byte sectors)
UDF-fs DEBUG fs/udf/super.c:1208:udf_check_valid: Failed to read byte 
32768. Assuming open disc. Skipping validity check
UDF-fs DEBUG fs/udf/misc.c:286:udf_read_tagged: location mismatch block 
256, tag 18 != 256
UDF-fs DEBUG fs/udf/super.c:1262:udf_load_partition: No Anchor block found
UDF-fs: No partition found (1)
found reiserfs format "3.6" with standard journal

Is all this blurbage necessary?  I don't even have a disc in the 'rom 
drive because it causes the kernel to lock up hard on bootup if I do.  
Right at the moment, the 'rom isn't even plugged in.

David

