Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266233AbTBXK0u>; Mon, 24 Feb 2003 05:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266308AbTBXK0u>; Mon, 24 Feb 2003 05:26:50 -0500
Received: from 237.redhat.com ([213.86.99.237]:36301 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S266233AbTBXK0u>; Mon, 24 Feb 2003 05:26:50 -0500
Subject: Re: Root file system as CRAMFS on Flash
From: David Woodhouse <dwmw2@infradead.org>
To: purushn@future.futsoft.com
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
In-Reply-To: <002a01c2dbee$e8a7b6c0$1504060a@future.futsoft.com>
References: <002a01c2dbee$e8a7b6c0$1504060a@future.futsoft.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046083004.1545.32.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 24 Feb 2003 10:36:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-24 at 10:24, Purushothaman N wrote:
> Dear All,
> 
> Sorry for disturbing the list again. I was successfully able to mount a
> cramfs
> image in flash with NFS as root file system. But i am facing problems with
> mounting the cramfs image as root file system. I have given the correct root
> option
> to the kernel. 

No you haven't. Turn off devfs or change it to 'root=/dev/mtdblock/2'

-- 
dwmw2
