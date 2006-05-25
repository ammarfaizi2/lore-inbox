Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbWEYMfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbWEYMfE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 08:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbWEYMfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 08:35:04 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:37320 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S965122AbWEYMfC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 08:35:02 -0400
Date: Thu, 25 May 2006 14:35:00 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: 3ware 7500 not working in 2.6.16.18, 2.6.17-rc5
Message-ID: <20060525123500.GH19612@fi.muni.cz>
References: <20060525122240.GG19612@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060525122240.GG19612@fi.muni.cz>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak wrote:
: 	Hi all,
: 
: I have a 3ware 75xx P-ATA controller, which has been working in 2.6.15-rc2.
: Today I have tried to upgrade to 2.6.16.18, and it cannot boot - the
: controller cannot access the drives, with the attached messages.
: I have also tried 2.6.17-rc5 with the same results.

	An additional note: I use "iommu=off" boot option (I had some
problems using IOMMU in the past, so I have disabled it). Without
this option, 2.6.16.18 boots correctly (I have not stress-tested the
system yet, so I don't know whether the IOMMU problems are solved).
But nevertheless, it would be nice to have 3ware driver working
even with iommu=off.

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
> I will never go to meetings again because I think  face to face meetings <
> are the biggest waste of time you can ever have.        --Linus Torvalds <
