Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbUDTAYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUDTAYo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 20:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbUDTAYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 20:24:44 -0400
Received: from terminus.zytor.com ([63.209.29.3]:41176 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261865AbUDTAYn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 20:24:43 -0400
Message-ID: <40846DB7.4090102@zytor.com>
Date: Mon, 19 Apr 2004 17:24:23 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Venkata Ravella <Venkata.Ravella@synopsys.com>
CC: raven@themaw.net, linux-kernel@vger.kernel.org,
       Ramki.Balasubramanium@synopsys.com, ab@californiadigital.com,
       autofs@linux.kernel.org
Subject: Re: Automount/NFS issues causing executables to appear corrupted
References: <200404200008.i3K08Zvs018948@radium.internal.synopsys.com>
In-Reply-To: <200404200008.i3K08Zvs018948@radium.internal.synopsys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venkata Ravella wrote:
> autofs version is autofs-3.1.7-21
> 
> I also have one new update. We started seeing similar problem on
> the system running the kernel 2.4.18-e.12smp which has the same
> version(3.1.7-21) of autofs as well.
> 
> This may or may not be an autofs problem but, restarting autofs
> fixes this problem temporarily.
> 

That will cause an NFS remount.  This really feels much more like an NFS
problem.

	-hpa

