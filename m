Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbVAEOSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVAEOSj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 09:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbVAEOSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 09:18:39 -0500
Received: from 212-28-208-94.customer.telia.com ([212.28.208.94]:54802 "EHLO
	www.dewire.com") by vger.kernel.org with ESMTP id S262442AbVAEOSf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 09:18:35 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: data rescue
Date: Wed, 5 Jan 2005 15:18:29 +0100
User-Agent: KMail/1.7.1
References: <00e801c4f32e$bde1e600$7861a8c0@pcp40702>
In-Reply-To: <00e801c4f32e$bde1e600$7861a8c0@pcp40702>
Cc: sujeet.kumar@patni.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501051518.29918.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

onsdagen den 5 januari 2005 14.59 skrev Sujeet Kumar:
> I ran
> blockdev -v --rereadpt ....
> on my harddisk .
> It gave re-read partition succeded. Then after rebooting the machine it
> shows no partitions.
>
> I tried running linux-rescue from bootable disk and it shows no valid
> partition table.
> How do i rescue my data . 
gpart can recover partition tables. I used it to recover a failed disk where 
the extended partitions were screwed due to a disk  failure. Every attempt to 
restore the tables on disk failed. The partion table grew stranger each time, 
but I could recover data from a disk image. 

> Tell me what rereadpt basically does 
no idea other than the man page....,sorry.

-- robin
