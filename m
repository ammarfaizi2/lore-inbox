Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269252AbTGJMbA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 08:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269253AbTGJMbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 08:31:00 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:7349
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S269252AbTGJMa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 08:30:59 -0400
Subject: Re: RFC:  what's in a stable series?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.55L.0307100910550.7857@freak.distro.conectiva>
References: <3F0CBC08.1060201@pobox.com>
	 <Pine.LNX.4.55L.0307100040271.6629@freak.distro.conectiva>
	 <20030710085338.C28672@infradead.org>
	 <1057835998.8028.6.camel@dhcp22.swansea.linux.org.uk>
	 <Pine.LNX.4.55L.0307100910550.7857@freak.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057840919.8027.19.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jul 2003 13:42:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-10 at 13:13, Marcelo Tosatti wrote:
> So Christoph's quota patch does not support vendors "v1" files?
> 
> I must be misunderstanding someone.

There are three species of quota in Linux

v0	(official old Linux)
v1	(most 2.4 vendor trees)
v2	(the 2.5 format)

[Plus other per file system stuff that is abstracted by the quota
updates and used by folks like XFS]

The v1 quota definitely doesn't belong in 2.5, but its needed by a
lot of 2.4 users who come from vendor trees (and may want to go back
again)


