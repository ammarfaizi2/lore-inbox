Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262649AbVAEUb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbVAEUb5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 15:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVAEUbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 15:31:09 -0500
Received: from host.atlantavirtual.com ([209.239.35.47]:467 "EHLO
	host.atlantavirtual.com") by vger.kernel.org with ESMTP
	id S262649AbVAEU2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 15:28:42 -0500
Subject: Re: data rescue
From: kernel <kernel@crazytrain.com>
Reply-To: kernel@crazytrain.com
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, sujeet.kumar@patni.com
In-Reply-To: <200501051518.29918.robin.rosenberg.lists@dewire.com>
References: <00e801c4f32e$bde1e600$7861a8c0@pcp40702>
	 <200501051518.29918.robin.rosenberg.lists@dewire.com>
Content-Type: text/plain
Message-Id: <1104956707.3907.61.camel@crazytrain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 05 Jan 2005 15:25:07 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-05 at 09:18, Robin Rosenberg wrote:
> > I tried running linux-rescue from bootable disk and it shows no valid
> > partition table.
> > How do i rescue my data . 

In addition to 'gpart' you can try 'rescuept' which is part of
util-linux collection.   Each of these may rescue your corrupt partition
table.  

Do you have any idea of the partitioning schema?  Number of partitions,
size, etc.?

If both fail to reconstruct the partition table you can work with a
forensic utility such as SMART for Linux (www.asrdata.com) or The Sleuth
Kit (www.sleuthkit.org) to recover your files.  Depending upon the FS
TYPE(s) you may even get deleted files back.  

No matter though, once you get everything worked out back up your
partition table using 'sfdisk' and/or dd and dump that to a safe place
(external media) so that if this happens in future you can reconstruct
easily!

-fd

