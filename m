Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbWEKPPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbWEKPPb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 11:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWEKPPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 11:15:30 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:34787 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id S1030251AbWEKPPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 11:15:30 -0400
From: Paul Slootman <paul+nospam@wurtel.net>
Subject: Re: [dm-crypt] dm-crypt is broken and causes massive data corruption
Date: Thu, 11 May 2006 15:15:29 +0000 (UTC)
Organization: Wurtelization
Message-ID: <e3vkeh$12h$1@news.cistron.nl>
References: <445F7DCC.2000508@igd.fraunhofer.de> <20060509190457.GL16180@agk.surrey.redhat.com>
X-Trace: ncc1701.cistron.net 1147360529 1105 83.68.3.130 (11 May 2006 15:15:29 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alasdair G Kergon  <agk@redhat.com> wrote:
>On Mon, May 08, 2006 at 07:20:12PM +0200, Tillmann Steinbrecher wrote:
>> it's been many months that dm-crypt has been broken, and is known to 
>> cause massive data corruption.

>So far there isn't much in the way of controlled experiments, but:
>
>  All the reports agree the problem is independent of filesystem.
>
>  One thread suggests only filesystem metadata is corrupted, not file
>  data, and wonders if something's going wrong with (unsupported) write 
>  barriers.
>
>  Another report said dm-crypt over raid5 failed while raid5 
>  over dm-crypt worked.

A data point:

I'm running my /home on reiserfs3 over dm-crypt over lvm over raid5 for
at least a year now, without any problems. Currently running 2.6.13.4
(that's my "stable" work system...).


Paul Slootman

