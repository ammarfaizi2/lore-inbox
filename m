Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWDGPiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWDGPiN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 11:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWDGPiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 11:38:13 -0400
Received: from web32207.mail.mud.yahoo.com ([68.142.207.138]:9810 "HELO
	web32207.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964806AbWDGPiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 11:38:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=L8cwrNNtYYulzjZ6l6dwphQcEQAQ7upj0SL09zHjj3qregsVqV0gNEanBzuKpUDSbt5QY29hthsfAQrvxN+Pa3CKtVOaniFHMbvvNVIgk749SPyDNrjhNR+PnJLoBqSipAT2fhShV1dxKY8XczilvnHGhBE59cixE62BTaYqRjo=  ;
Message-ID: <20060407153810.23565.qmail@web32207.mail.mud.yahoo.com>
Date: Fri, 7 Apr 2006 08:38:10 -0700 (PDT)
From: Bhattiprolu Ravi Kumar <ravikumar_b@yahoo.com>
Subject: Problem with using __getblk
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to write a module to directly read from
the disk. I have got the sector numbers where the file
present using file system functions. This file starts
from sector 96 on /dev/hda4 for example. The call to
__getblk as
bh = __getblk(bdev,96,512) makes the system hang. Do I
need to add the partition offset also to the sector
number? When I added partition start sector,. I am
getting junk data using ll_rw_block call.

Please advice.

Note: Please send reply to my email address

thanks,
Ravi 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
