Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVDTS6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVDTS6N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 14:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVDTS6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 14:58:12 -0400
Received: from fmr19.intel.com ([134.134.136.18]:64898 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261737AbVDTS6H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 14:58:07 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.12-rc2-mm3 pciehp regression
Date: Wed, 20 Apr 2005 11:56:30 -0700
Message-ID: <468F3FDA28AA87429AD807992E22D07E04FC7DD9@orsmsx408>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.12-rc2-mm3 pciehp regression
Thread-Index: AcVB9BYgHpwx0nBdSVW+e2G8bUNddwD5DqxQ
From: "Sy, Dely L" <dely.l.sy@intel.com>
To: <Tom.Duffy@Sun.COM>
Cc: <pcihpd-discuss@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Apr 2005 18:56:31.0930 (UTC) FILETIME=[AAB801A0:01C545DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, April 15, 2005 12:48 PM, Tom Duffy wrote:
> From: "Sy, Dely L" <dely.l.sy@intel.com>
> > Thanks for reporting this.  I'll look into it.  Which was the last 
> > kernel you tested on your hw and worked for you?

> That is a good question.  I think it was a 2.6.11 kernel.  It was 
> definately before express was moved to a different directory, 
> whenever that occured.

Tom,

I was not able to duplicate this problem on my system yet for I have
trouble in getting my system booted up on 2.6.12-rc2-mm3.  I did some
back-tracking and found that the boot problem occurred also with 
2.6.12-rc2-mm2 & 2.6.12-rc2-mm3, and on two systems using IDE as boot 
drive. The config file I used worked fine on 2.6.11.7. I tried 
different config file without success.

The errors I encountered were:
Reading all physical volumes.  This may take a while...
Umount /sys failed: 16
mount: error 6 mounting ext3
mount: error 2 mounting none
Switching to new root
Switchroot: mount failed 22
umount /initrd/dev failed: 2

I also encountered issue you & others discussed in the thread on
"Re: Heads up on 2.6.12-rc1 and later" if I used SCSI drive.

Can you send me the config file you used successfully on your 
system?

Thanks,
Dely
