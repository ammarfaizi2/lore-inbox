Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310241AbSCVIxt>; Fri, 22 Mar 2002 03:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310501AbSCVIxj>; Fri, 22 Mar 2002 03:53:39 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:13704 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S310241AbSCVIxY>; Fri, 22 Mar 2002 03:53:24 -0500
Date: Fri, 22 Mar 2002 03:53:21 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Axel Kittenberger <Axel.Kittenberger@maxxio.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
        Axel Kittenberger <Axel.Kittenberger@maxxio.at>,
        linux-kernel@vger.kernel.org
Subject: Re: Patch, forward release() return values to the close() call
Message-ID: <20020322035321.B8052@devserv.devel.redhat.com>
In-Reply-To: <mailman.1016697001.29134.linux-kernel2news@redhat.com> <200203211845.g2LIjTu22218@devserv.devel.redhat.com> <200203220806.JAA10107@merlin.gams.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Axel Kittenberger <Axel.Kittenberger@maxxio.com>
> Date: Fri, 22 Mar 2002 09:06:38 +0100

>[...]
> So when closing a file with write-behind cache, close() signals in example an 
> error (it """fails"""), as application I do not have close it again or to 
> circle, but I have to live with the fact that something went wrong, [...]

I do not think it's true. And what about exit()?

-- Pete
