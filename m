Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317525AbSHHM4M>; Thu, 8 Aug 2002 08:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317536AbSHHM4M>; Thu, 8 Aug 2002 08:56:12 -0400
Received: from reload.namesys.com ([212.16.7.75]:55943 "EHLO
	reload.namesys.com") by vger.kernel.org with ESMTP
	id <S317525AbSHHM4L>; Thu, 8 Aug 2002 08:56:11 -0400
Date: Thu, 8 Aug 2002 16:59:49 +0400
From: Joshua MacDonald <jmacd@namesys.com>
To: Eli Carter <eli.carter@inet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Idle curiosity: Acting as a SCSI target
Message-ID: <20020808125949.GB8804@reload.namesys.com>
Mail-Followup-To: Eli Carter <eli.carter@inet.com>,
	linux-kernel@vger.kernel.org
References: <3D519357.7070904@inet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D519357.7070904@inet.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 04:38:31PM -0500, Eli Carter wrote:
> Based on a conversation I had recently, my curiosity got piqued...
> 
> I'm not really sure how to query google on this, and didn't turn up what 
> I was looking for because of that, so here's the random question:
> 
> Is there a way to make a Linux machine with a scsi controller act like a 
> scsi device (is the correct term 'target'?) (such as a disk) using a 
> local block device as storage?
> 
> I'm not sure it would be of general use, but I can see uses in weird or 
> remote prototyping situations...
> 
> Like the subject says, just idle curiosity; I don't see having much use 
> for it, but I was intrigued by the idea.

SCSI targets are also quite useful for testing disk-failure handling in file
systems, RAID devices, and databases...

http://www.cs.berkeley.edu/~abrown/papers/usenix00.pdf

-josh
