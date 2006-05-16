Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751545AbWEPGrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbWEPGrA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 02:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbWEPGq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 02:46:59 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:11368 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751545AbWEPGq7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 02:46:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ADgZt+Yyas2uYIhfFgrff6eij9CjP0L7a9bzCXCm7o8xuxSao/7TkzbOy/4proas92Dlf6Ncmp5TBPmZr29KErKJTQd/4nHFAo+eeLKYKMX23p7wY6Mn9gjWuS31nG1X2Ut40sxjrrtDcumWSRWD7fmlmmwB18qmvKVXsjlBIlw=
Message-ID: <8bf247760605152346m72a8b43ci325cc0bb7d68b576@mail.gmail.com>
Date: Mon, 15 May 2006 23:46:58 -0700
From: Ram <vshrirama@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: SDIO - crc check of previous command failed
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I am trying to write an sdio driver.

   I have sent command 52 with argument of 0x00001000 to get the block size.

   In return i get an response of 0x00001000 which indicates that the
CRC Check of the previous   command failed.

   The last command i sent was command 7 and it returned success.


   Any clues where the problem could be?.


Regards,
sriram
