Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266547AbUIOQO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266547AbUIOQO2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266725AbUIOQN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 12:13:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20145 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266547AbUIOQLg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 12:11:36 -0400
Message-ID: <414869AB.5070307@pobox.com>
Date: Wed, 15 Sep 2004 12:11:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ricky Beam <jfbeam@bluetronic.net>,
       Zilvinas Valinskas <zilvinas@gemtek.lt>,
       Erik Tews <erik@debian.franken.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 rc2 freezing
References: <Pine.GSO.4.33.0409151047560.10693-100000@sweetums.bluetronic.net>	 <1095263296.2406.141.camel@krustophenia.net>  <41486691.3080202@pobox.com> <1095264408.2406.148.camel@krustophenia.net>
In-Reply-To: <1095264408.2406.148.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> Anyway, if you are running anything on your server that breaks under
> PREEMPT, it will break anyway as soon as you add another processor.

Incorrect.  The spinlock behavior is very different.

That's why we had net stack problems in the past under preempt but not 
under SMP.

	Jeff


