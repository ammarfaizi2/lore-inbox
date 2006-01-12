Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161475AbWALXhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161475AbWALXhe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 18:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161476AbWALXhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 18:37:34 -0500
Received: from nsa.as.arizona.edu ([128.196.210.37]:17087 "EHLO
	nsa3.srv.as.arizona.edu") by vger.kernel.org with ESMTP
	id S1161475AbWALXhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 18:37:33 -0500
Message-ID: <43C6E834.7040402@as.arizona.edu>
Date: Thu, 12 Jan 2006 16:37:24 -0700
From: don fisher <dfisher@as.arizona.edu>
Organization: Steward Observatory
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: machine check errors
Content-Type: multipart/mixed;
 boundary="------------060900030300080004040805"
X-so-MailScanner-Information: Please contact the ISP for more information
X-so-MailScanner: Found to be clean
X-so-MailScanner-SpamCheck: so3: not spam, SpamAssassin (score=-0.593,
	required 8, autolearn=disabled, AWL -0.59)
X-so-MailScanner-From: dfisher@as.arizona.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060900030300080004040805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I have a Tyan S2892 board with a pair Opteron 288 dual core cpus and 
16GB dram. I receive the errors shown in the attached file, mcelog. It 
appears that these occur when the free memory becomes small, there is 
a lot in the cache, and a lot of IO.

The Tyan S2892 has an Nvidia Crush K8-04, which I think they call the 
southbridge. My errors appear to be related to the north bridge. There 
is an AMD 8131 PCI-X controller that runs the PCI slots. There is a 
3WARE 9500-12 located in one of the PCI-X slots.

I have run Memtest86+-1.65 for 24 hours without errors. I recently 
upgraded the BIOS to V2.00 without any remarkable changes.

I am running 2.6.15 within a current Fedora Core4 configuration.

I would appreciate any advice as to how to proceed. I have not noticed 
any adverse behavior from the mce's. But that could be masked is data 
transfered or ???.

Could there be any connection with the memory cache? Thanks in advance 
for your assistance.

don
-- 


--------------060900030300080004040805
Content-Type: text/plain;
 name="mcelog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mcelog"

MCE 0
CPU 2 4 northbridge TSC 967b1992c66 
ADDR 2a52cb5f0 
  Northbridge Chipkill ECC error
  Chipkill ECC syndrome = 40b9
       bit32 = err cpu0
       bit46 = corrected ecc error
       bit62 = error overflow (multiple errors)
  bus error 'local node origin, request didn't time out
      generic read mem transaction
      memory access, level generic'
STATUS d45cc00140080813 MCGSTATUS 0
MCE 1
CPU 2 4 northbridge TSC a101bbf7338 
ADDR 2922df698 
  Northbridge Chipkill ECC error
  Chipkill ECC syndrome = 6051
       bit46 = corrected ecc error
       bit62 = error overflow (multiple errors)
  bus error 'local node response, request didn't time out
      generic read mem transaction
      memory access, level generic'
STATUS d428c00060080a13 MCGSTATUS 0
MCE 2
CPU 2 4 northbridge TSC ab885e5bdbe 
ADDR 2922df698 
  Northbridge Chipkill ECC error
  Chipkill ECC syndrome = 6051
       bit46 = corrected ecc error
       bit62 = error overflow (multiple errors)
  bus error 'local node response, request didn't time out
      generic read mem transaction
      memory access, level generic'
STATUS d428c00060080a13 MCGSTATUS 0
MCE 0
CPU 2 4 northbridge TSC b60f17bf394 
ADDR 2918d98d0 
  Northbridge Chipkill ECC error
  Chipkill ECC syndrome = 6051
       bit46 = corrected ecc error
       bit62 = error overflow (multiple errors)
  bus error 'local node response, request didn't time out
      generic read mem transaction
      memory access, level generic'
STATUS d428c00060080a13 MCGSTATUS 0
MCE 1
CPU 2 4 northbridge TSC c095ba23a7e 
ADDR 2918cdff0 
  Northbridge Chipkill ECC error
  Chipkill ECC syndrome = 40b9
       bit46 = corrected ecc error
       bit62 = error overflow (multiple errors)
  bus error 'local node response, request didn't time out
      generic read mem transaction
      memory access, level generic'
STATUS d45cc00040080a13 MCGSTATUS 0
MCE 2
CPU 2 4 northbridge TSC cb1c7387269 
ADDR 2bf0cfa50 
  Northbridge Chipkill ECC error
  Chipkill ECC syndrome = 6051
       bit46 = corrected ecc error
       bit62 = error overflow (multiple errors)
  bus error 'local node response, request didn't time out
      generic read mem transaction
      memory access, level generic'
STATUS d428c00060080a13 MCGSTATUS 0
MCE 3
CPU 2 4 northbridge TSC d5a315f1a34 
ADDR 2900df990 
  Northbridge Chipkill ECC error
  Chipkill ECC syndrome = 20e8
       bit46 = corrected ecc error
       bit62 = error overflow (multiple errors)
  bus error 'local node response, request didn't time out
      generic read mem transaction
      memory access, level generic'
STATUS d474400020080a13 MCGSTATUS 0
MCE 4
CPU 2 4 northbridge TSC e029b8504a6 
ADDR 2900dd030 
  Northbridge Chipkill ECC error
  Chipkill ECC syndrome = 6051
       bit46 = corrected ecc error
       bit62 = error overflow (multiple errors)
  bus error 'local node response, request didn't time out
      generic read mem transaction
      memory access, level generic'
STATUS d428c00060080a13 MCGSTATUS 0
MCE 5
CPU 2 4 northbridge TSC eab071b5316 
ADDR 291ac9d98 
  Northbridge Chipkill ECC error
  Chipkill ECC syndrome = 6051
       bit46 = corrected ecc error
       bit62 = error overflow (multiple errors)
  bus error 'local node response, request didn't time out
      generic read mem transaction
      memory access, level generic'
STATUS d428c00060080a13 MCGSTATUS 0
MCE 6
CPU 2 4 northbridge TSC f537141ab1c 
ADDR 2918dfe78 
  Northbridge Chipkill ECC error
  Chipkill ECC syndrome = 40b9
       bit33 = err cpu1
       bit46 = corrected ecc error
       bit62 = error overflow (multiple errors)
  bus error 'local node origin, request didn't time out
      generic read mem transaction
      memory access, level generic'
STATUS d45cc00240080813 MCGSTATUS 0
MCE 7
CPU 2 4 northbridge TSC ffbdb67fd26 
ADDR 2beac9010 
  Northbridge Chipkill ECC error
  Chipkill ECC syndrome = 40b9
       bit46 = corrected ecc error
       bit62 = error overflow (multiple errors)
  bus error 'local node response, request didn't time out
      generic read mem transaction
      memory access, level generic'
STATUS d45cc00040080a13 MCGSTATUS 0
MCE 0
CPU 2 4 northbridge TSC 10a446fe04fa 
ADDR 2cfcc9870 
  Northbridge Chipkill ECC error
  Chipkill ECC syndrome = 40b9
       bit32 = err cpu0
       bit46 = corrected ecc error
       bit62 = error overflow (multiple errors)
  bus error 'local node origin, request didn't time out
      generic read mem transaction
      memory access, level generic'
STATUS d45cc00140080813 MCGSTATUS 0
MCE 1
CPU 2 4 northbridge TSC 114cb12451a2 
ADDR 291ac9630 
  Northbridge Chipkill ECC error
  Chipkill ECC syndrome = 6051
       bit33 = err cpu1
       bit46 = corrected ecc error
       bit62 = error overflow (multiple errors)
  bus error 'local node origin, request didn't time out
      generic read mem transaction
      memory access, level generic'
STATUS d428c00260080813 MCGSTATUS 0
MCE 2
CPU 2 4 northbridge TSC 11f51cba9b82 
ADDR 2c10cb010 
  Northbridge Chipkill ECC error
  Chipkill ECC syndrome = 20e8
       bit32 = err cpu0
       bit46 = corrected ecc error
       bit62 = error overflow (multiple errors)
  bus error 'local node origin, request didn't time out
      generic read mem transaction
      memory access, level generic'
STATUS d474400120080813 MCGSTATUS 0
MCE 3
CPU 2 4 northbridge TSC 129d86e0d26a 
ADDR 294ec9390 
  Northbridge Chipkill ECC error
  Chipkill ECC syndrome = 6051
       bit32 = err cpu0
       bit46 = corrected ecc error
       bit62 = error overflow (multiple errors)
  bus error 'local node origin, request didn't time out
      generic read mem transaction
      memory access, level generic'
STATUS d428c00160080813 MCGSTATUS 0

--------------060900030300080004040805--
