Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUHBTpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUHBTpN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 15:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUHBTpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 15:45:13 -0400
Received: from mail.inter-page.com ([12.5.23.93]:41222 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S262574AbUHBTpJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 15:45:09 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'David S. Miller'" <davem@redhat.com>, <arjanv@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: tcp_push_pending_frames() without TCP_CORK or TCP_NODELAY
Date: Mon, 2 Aug 2004 12:44:41 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAbqjYSy59TU+ukzdi1lcNqgEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20040801195411.0577b7f2.davem@redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there an argument _against_ providing an explicit flush?


-----Original Message-----
From: David S. Miller [mailto:davem@redhat.com] 
Sent: Sunday, August 01, 2004 7:54 PM
To: arjanv@redhat.com
Cc: rwhite@casabyte.com; linux-kernel@vger.kernel.org
Subject: Re: tcp_push_pending_frames() without TCP_CORK or TCP_NODELAY

On Sat, 31 Jul 2004 10:10:06 +0200
Arjan van de Ven <arjanv@redhat.com> wrote:

> btw do we export MSG_MORE functionality to userspace ? That might be a
> solution as well...

Yes, we do.



