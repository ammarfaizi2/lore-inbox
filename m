Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264205AbUDRXGM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 19:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264200AbUDRXGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 19:06:12 -0400
Received: from terminus.zytor.com ([63.209.29.3]:49847 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S264205AbUDRXGK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 19:06:10 -0400
Message-ID: <408309D8.4010601@zytor.com>
Date: Sun, 18 Apr 2004 16:06:00 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Venkata Ravella <Venkata.Ravella@synopsys.com>
CC: linux-kernel@vger.kernel.org,
       Ramki Balasubramanian <Ramki.Balasubramanium@synopsys.com>,
       ab@californiadigital.com
Subject: Re: Automount/NFS issues causing executables to appear corrupted
References: <20040418212346.GA23560@rearview.synopsys.com>
In-Reply-To: <20040418212346.GA23560@rearview.synopsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venkata Ravella wrote:
> The current kernel we use is default 7.2 kernel with two modifications:
> 1) BM patch applied to extend address space for a single process to 3.6GB
> 2) mnt patch applied to allow upto 1024 nfs mount points
> 
> uname -r output:
> 2.4.7-10mntBMsmp

In other words, you're using an ancient kernel with plenty of known 
problems, applied two additional patches to it, and are surprised you're 
having problems?

 > Unfortunately, upgrading to a newer kernel is not an option for us at 
 > the moment.

Sucks to be you.

	-hpa

