Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267874AbUHKCFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267874AbUHKCFM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 22:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267876AbUHKCFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 22:05:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30852 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267874AbUHKCFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 22:05:08 -0400
Date: Tue, 10 Aug 2004 22:04:49 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Roger Luethi <rl@hellgate.ch>
cc: faith@redhat.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] audit code
In-Reply-To: <20040810211245.GA7646@k3.hellgate.ch>
Message-ID: <Xine.LNX.4.44.0408102203390.10585-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004, Roger Luethi wrote:

> - audit_receive_skb always returns 0; therefore, the condition
>   in audit_receive is always false.

If it always returns zero, then it should also be changed to void fn(...).


- James
-- 
James Morris
<jmorris@redhat.com>


