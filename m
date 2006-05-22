Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWEVTgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWEVTgZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 15:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWEVTgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 15:36:25 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:10769 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1751149AbWEVTgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 15:36:24 -0400
Message-ID: <447212B5.1010208@argo.co.il>
Date: Mon, 22 May 2006 22:36:21 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: fitzboy <fitzboy@iparadigms.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: tuning for large files in xfs
References: <447209A8.2040704@iparadigms.com> <44720DB8.4060200@argo.co.il> <447211E1.7080207@iparadigms.com>
In-Reply-To: <447211E1.7080207@iparadigms.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 May 2006 19:36:23.0250 (UTC) FILETIME=[020D3B20:01C67DD7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fitzboy wrote:
> That makes sense, but how come the numbers for the large file (2TB)
> doesn't seem to match with the Avg. Seek Time that 15k drives have? Avg
> Seek Time for those drives are in the 5ms range, and I assume they
> aren't just seeking in the first couple tracks when they come up with
> that number (and Bonnie++ confirms this too). Any thoughts on why it is
> double for me when I use the drives?
>

What's your testing methodology?

You can try to measure the amount of seeks going to the disk by using 
iostat, and see if that matches your test program.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

