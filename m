Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTH2XKB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 19:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbTH2XKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 19:10:01 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:37875 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261929AbTH2XJ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 19:09:58 -0400
Message-ID: <3F4FDD44.4151E86C@mvista.com>
Date: Fri, 29 Aug 2003 17:09:56 -0600
From: Michael Pruznick <michael_pruznick@mvista.com>
Reply-To: michael_pruznick@mvista.com
Organization: MontaVista
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: root=nfs no longer works in 2.4.22
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Was root=nfs removed on purpose or is it an unexpected
side effect of the "ROOT NFS fixes" patch from late
July 2003?

I understand this patch from the point of wanting to
eliminate nfs attempts when nfs is not requested.  That
is clearly a reasonable thing to do.  However, "root=nfs"
is a nfs request that has been accepted in the past, I've
been told, because nfs isn't a real device (but maybe it
was accepted as bug and this patch fixed it).
