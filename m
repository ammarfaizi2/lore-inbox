Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbULNRm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbULNRm2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 12:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbULNRmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 12:42:10 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:55264 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261572AbULNRk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 12:40:57 -0500
Message-ID: <41BF2598.4050206@nortelnetworks.com>
Date: Tue, 14 Dec 2004 11:40:40 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: how to add 32/64 compatible ioctls at runtime via module?
References: <200412141727.iBEHRcaj012562@harpo.it.uu.se>
In-Reply-To: <200412141727.iBEHRcaj012562@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:

> register_ioctl32_conversion(ioctl, handler)
> 
> tells your 64-bit kernel that the given ioctl, when issued by
> a 32-bit mode task, should be routed to the given handler.
> The handler can be NULL, in which case the ioctl is routed to
> the normal handler via the filp.

Excellent.  Thanks very much.

Chris
