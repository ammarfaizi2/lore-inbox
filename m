Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758538AbWK0To4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758538AbWK0To4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 14:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758535AbWK0To4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 14:44:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6119 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1757890AbWK0Toz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 14:44:55 -0500
Message-ID: <456B3FF2.3010908@redhat.com>
Date: Mon, 27 Nov 2006 11:43:46 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take25 1/6] kevent: Description.
References: <11641265982190@2ka.mipt.ru> <456621AC.7000009@redhat.com> <20061124120531.GC32545@2ka.mipt.ru>
In-Reply-To: <20061124120531.GC32545@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> It _IS_ how previous interface worked.
> 
> 	EXACTLY!

No, the old interface committed everything not only up to a given index. 
  This is the huge difference which makes or breaks it.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
