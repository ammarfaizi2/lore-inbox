Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVEIMn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVEIMn4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 08:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVEIMn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 08:43:56 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:36826 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261345AbVEIMnz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 08:43:55 -0400
Subject: Re: [PATCH 2.6.12-rc3-mm3] connector: add a fork connector
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Jay Lan <jlan@engr.sgi.com>, aq <aquynh@gmail.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <1115641352.936.45.camel@localhost.localdomain>
References: <1115626029.8548.24.camel@frecb000711.frec.bull.fr>
	 <1115631107.936.25.camel@localhost.localdomain>
	 <1115638724.8540.59.camel@frecb000711.frec.bull.fr>
	 <1115641352.936.45.camel@localhost.localdomain>
Date: Mon, 09 May 2005 14:43:47 +0200
Message-Id: <1115642627.8548.68.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/05/2005 14:54:21,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/05/2005 14:54:22,
	Serialize complete at 09/05/2005 14:54:22
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-09 at 14:22 +0200, Alexander Nyberg wrote:
> 
> And before any abi sets itself I think you might want to consider
> including both thread & process id of parent & child. This way the
> user-space client can distinguish what is a thread and a group leader
> although I admittedly don't know all your goals with this, just a
> thought.

Yes I completely agree :)

  I will include both thread & process id of parent and child in the
next release. I also removed the DEFINE_PER_CPU(...) from kernel/fork.c
and I use a call instead of putting the code in the header file.

Thank you for your comments,
Best regards,

Guillaume

