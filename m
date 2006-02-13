Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWBMJJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWBMJJl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 04:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbWBMJJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 04:09:41 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:64394 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751240AbWBMJJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 04:09:40 -0500
Date: Mon, 13 Feb 2006 10:09:34 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: JaniD++ <djani22@dynamicweb.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] NFS and new kernels.
In-Reply-To: <01c801c63039$de70c780$9d00a8c0@dcccs>
Message-ID: <Pine.LNX.4.61.0602131008320.2682@yvahk01.tjqt.qr>
References: <01c801c63039$de70c780$9d00a8c0@dcccs>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>This tells me: i am the stupid. :-)
>
>The general problem, is this:
>
>(client)[root@st-0001 root]# mount: 192.168.0.2://mountpoint failed, reason
>given by server: Permission denied

Bogus syntax, I'd say. //mountpoint is not the same as /mountpoint

>(server)[root@NetCenter log]# mount: localhost://mountpoint failed, reason
>given by server: Permission denied
>(client)[root@st-0001 root]# showmount -e 192.168.0.2
>/mnt/EXT                192.168.2.*
>/mnt/EXT/NFS/ROOT       (everyone)
>/mountpoint            st-0001
>etc...
>

Jan Engelhardt
-- 
