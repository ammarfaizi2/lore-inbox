Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbVDOX1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbVDOX1w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 19:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVDOX1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 19:27:52 -0400
Received: from main.gmane.org ([80.91.229.2]:3235 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262259AbVDOX1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 19:27:43 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: [SATA] status reports updated
Date: Sat, 16 Apr 2005 01:27:24 +0200
Message-ID: <yw1xmzrzaaeb.fsf@ford.inprovide.com>
References: <42600375.9080108@pobox.com> <42600E12.8020304@interia.pl>
 <42601474.5010008@tomt.net> <426017DC.1080801@interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:Qbq3w36fC8Co/h6t7lhq1ePjP68=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Chmielewski <mangoo@interia.pl> writes:

> Andre Tomt wrote:
>> Tomasz Chmielewski wrote:
>> <
>>
>>> [1] although my drive is blacklisted (Seagate barracuda -
>>> ST3200822AS), I "unblacklisted" it to get full performance - it's
>>> under heavy stress for 12th hour, and still no error.
>> It could be that your drive has newer firmware. Too bad firmware
>> upgrades for HD's are hard to come by nowadays.
>
> Is there a way to check what firmware a drive has (either by using
> some software - which would be the best option, or by reading a label
> on a drive)?

Seagate drives have the firmware version printed on the label.  The
version is also visible in "dmesg" output:

  Vendor: ATA       Model: ST3160827AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05

The "Rev" number is the firmware version.

-- 
Måns Rullgård
mru@inprovide.com

