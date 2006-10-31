Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423245AbWJaNfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423245AbWJaNfj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 08:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423248AbWJaNfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 08:35:39 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:2539 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1423245AbWJaNfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 08:35:39 -0500
Message-ID: <4547512E.8010603@cfl.rr.com>
Date: Tue, 31 Oct 2006 08:35:42 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Steve Grubb <sgrubb@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] handle ext3 directory corruption better
References: <200610211129.23216.sgrubb@redhat.com> <20061031095742.GA4241@ucw.cz>
In-Reply-To: <20061031095742.GA4241@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Oct 2006 13:35:46.0200 (UTC) FILETIME=[7848E980:01C6FCF1]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14784.003
X-TM-AS-Result: No--7.154700-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another expectation is that after the fsck, you won't loose any more 
data that you could access by mounting the damaged filesystem.  There 
are a lot of horror stories out there of people only having a slightly 
damaged fs, and after a fsck, they lost a lot more data.

Pavel Machek wrote:
> 
> Nice... can you run the same tool against fsck, too?
> 
> I did that some time ago, with less evil tool, and got some
> interesting results.
> 
> (Expectation is that no matter how you corrupt fs, fsck will get it
> back to consistent state...)
> 						Pavel

