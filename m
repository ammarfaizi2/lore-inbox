Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269818AbUJSRFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269818AbUJSRFp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 13:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269683AbUJSRAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 13:00:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12686 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269643AbUJSQig
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:36 -0400
Message-ID: <417542FF.8000800@pobox.com>
Date: Tue, 19 Oct 2004 12:38:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: alistair@devzero.co.uk
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9: performance issues on Via Epia
References: <200410191604.22747.alistair@devzero.co.uk>
In-Reply-To: <200410191604.22747.alistair@devzero.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> Hi,
> 
> I recently upgraded from 2.6.8.1 to 2.6.9 (the release, not -final) on my Via 
> Epia 5000 router. Now when I transfer files from the machine's HD vsftpd can 
> only achieve 3MB/s.
> 
> I believe this is some performance problem specifically related to XFS, or 
> something specific to the local VM, because if I transfer from an NFS mounted 
> directory on the same machine, vsftpd easily achieves the 10MB/s I'm used to.
> 
> Top shows something typical to this during transfers from the machine's local 
> HD;
> 
> Cpu(s):  0.7% us,  9.2% sy,  0.0% ni,  0.3% id, 84.5% wa,  5.3% hi,  0.0% si
> 
> Which seems like an awful lot of wait time. Anybody got any suggestions of 
> where to start reverting patches? The amount of difference between 2.6.8.1 
> and 2.6.9 is quite daunting.
> 
> By the way, copying a file locally on the system from the same partition to 
> another directory is far more efficient.
> 
> [root] 16:02 [~] time cp /var/cache/swapfile here
> `/var/cache/swapfile' -> `here'

check ethernet too...

	Jeff



