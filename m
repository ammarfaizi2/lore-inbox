Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVCUKsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVCUKsr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 05:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVCUKsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 05:48:47 -0500
Received: from imag.imag.fr ([129.88.30.1]:24456 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S261744AbVCUKsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 05:48:46 -0500
Message-ID: <423EA611.3030409@imag.fr>
Date: Mon, 21 Mar 2005 11:46:41 +0100
From: Raphael Jacquot <raphael.jacquot@imag.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050304
X-Accept-Language: en-us, en, fr-fr
MIME-Version: 1.0
To: Xin Zhao <uszhaoxin@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Why is NFS write so slow?
References: <4ae3c1405032100293ff52077@mail.gmail.com>
In-Reply-To: <4ae3c1405032100293ff52077@mail.gmail.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Mon, 21 Mar 2005 11:48:41 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xin Zhao wrote:
> Sorry for the dumb question. 
> 
> I am trying to develop a new filesystem based on NFS, which runs in a
> very fast network environment. I used the source code of NFS2, but
> noticed that NFS write is very slow. Even if I changed wsize to 8192,
> it still can only reach 1MB/s. I don't know why. Because the network
> is extremely fast (over 100MB/s), I don't think network is the only
> reason. Any other reason?
> 
> Is the NFS write synchronous? Does that means the NFS server will not
> return before the data is flushed to disk?  Because nfsd_write will
> close the file every time, I will assume that the data will be flushed
> to disk before return. However, even if I change nfsd_write to stop
> closing file, the write speed is still very slow. Can someone give me
> some advice about this?
> 
> Thanks in advance!

because NFS is now at version 4, so you're 2 versions late ?
