Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129694AbRCAQRP>; Thu, 1 Mar 2001 11:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129696AbRCAQRF>; Thu, 1 Mar 2001 11:17:05 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:60422 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129694AbRCAQQz>;
	Thu, 1 Mar 2001 11:16:55 -0500
Date: Thu, 1 Mar 2001 17:16:37 +0100
From: Jens Axboe <axboe@suse.de>
To: Phil Carinhas <pac@fortuitous.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mount -loop freezes on 2.4.2
Message-ID: <20010301171637.S21518@suse.de>
In-Reply-To: <20010301101550.A1416@bistro.marx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010301101550.A1416@bistro.marx>; from pac@fortuitous.com on Thu, Mar 01, 2001 at 10:15:50AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01 2001, Phil Carinhas wrote:
>  The following commands lockup on exectution. No logs generated, 
>   and there is no way to kill the process:
> 
> This is the 2.4.2 kernel running on mandrake 7.2
> 
>  mount /iso/Conectiva-61beta.iso /alt -o loop=/dev/loop0
>  mount /iso/Conectiva-61beta.iso /alt -o loop
> 
> 
>  There is no error reported and the file does fail to mount.
>  Works ok with 2.4.1 in read mode.. Riel says it fails in write on 2.4.1

Use -ac7 instead

-- 
Jens Axboe

