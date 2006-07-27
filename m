Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWG0LLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWG0LLt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 07:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWG0LLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 07:11:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:43469 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751242AbWG0LLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 07:11:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Oah6WQNPsSLlYOepiEmYHXstbQoyACgyDauggHRwH6o9CITxtgIfm5DWYXfXrEToySrfGlDbfgmb6QHV3vMPigahALAjYh/2suAb9rBRoOrgGclvG7vdJ77k16ksD9tXlJnt+x3mtt6JnJF1IPB4MT2+LJTo/rcR/+Zxft/dn4g=
Message-ID: <fbe022af0607270411u78ad633m650063061ea6bd5@mail.gmail.com>
Date: Thu, 27 Jul 2006 04:11:47 -0700
From: "Vikas Kedia" <kedia.vikas@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Can we ignore errors in mcelog if the server is running fine
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The server seems to be running fine. A. can I ignore the following
mcelog errors ? B. If not what should i do to stop the server from
reporting mcelog errors.

root@srv3:~# less /var/log/mcelog
MCE 0
CPU 0 0 data cache TSC 997fa760e9
ADDR 2c13340
  Data cache ECC error (syndrome e3)
       bit46 = corrected ecc error
  bus error 'local node origin, request didn't time out
      data read mem transaction
      memory access, level generic'
STATUS 9471c00000000833 MCGSTATUS 0
MCE 0
CPU 0 0 data cache TSC 1afa02913ab
ADDR 2c13380
  Data cache ECC error (syndrome e3)
       bit46 = corrected ecc error
       bit62 = error overflow (multiple errors)
  bus error 'local node origin, request didn't time out
      data read mem transaction
      memory access, level generic'
STATUS d471c00000000833 MCGSTATUS 0
root@srv3:~# pwd
/root
root@srv3:~# less /var/log/mcelog
MCE 0
CPU 0 0 data cache TSC 997fa760e9
ADDR 2c13340
  Data cache ECC error (syndrome e3)
       bit46 = corrected ecc error
  bus error 'local node origin, request didn't time out
      data read mem transaction
      memory access, level generic'
STATUS 9471c00000000833 MCGSTATUS 0
MCE 0
CPU 0 0 data cache TSC 1afa02913ab
ADDR 2c13380
  Data cache ECC error (syndrome e3)
       bit46 = corrected ecc error
       bit62 = error overflow (multiple errors)
  bus error 'local node origin, request didn't time out
      data read mem transaction
      memory access, level generic'
STATUS d471c00000000833 MCGSTATUS 0


Best regards,

v
