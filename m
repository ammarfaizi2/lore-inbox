Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263979AbUFPPca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263979AbUFPPca (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 11:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264048AbUFPPc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 11:32:29 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:13327 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263979AbUFPPcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 11:32:23 -0400
Message-ID: <40D06C0B.7020005@techsource.com>
Date: Wed, 16 Jun 2004 11:49:31 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Petter Larsen <pla@morecom.no>
CC: ext3 <ext3-users@redhat.com>, ext3@philwhite.org, Nicolas.Kowalski@imag.fr,
       linux-kernel@vger.kernel.org
Subject: Re: mode data=journal in ext3. Is it safe to use?
References: <40FB8221D224C44393B0549DDB7A5CE83E31B1@tor.lokal.lan> <1087322976.1874.36.camel@pla.lokal.lan>
In-Reply-To: <1087322976.1874.36.camel@pla.lokal.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Petter Larsen wrote:

> 
> Data integrity is much more important for us than speed.
> 


You might want to consider ReiserFS or one of the others which were 
designed with journaling in mind.  And I hope you're using RAID1 or RAID5.

