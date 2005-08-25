Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbVHYU5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbVHYU5s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 16:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbVHYU5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 16:57:48 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:24570 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1751373AbVHYU5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 16:57:47 -0400
Message-ID: <430E30B2.1020700@nortel.com>
Date: Thu, 25 Aug 2005 14:57:22 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vadim Lobanov <vlobanov@speakeasy.net>
CC: linux-kernel@vger.kernel.org, tom.anderl@gmail.com
Subject: Re: [OT] volatile keyword
References: <Pine.LNX.4.58.0508251335280.4315@shell2.speakeasy.net>
In-Reply-To: <Pine.LNX.4.58.0508251335280.4315@shell2.speakeasy.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vadim Lobanov wrote:

> I'm positive I'm doing something wrong here. In fact, I bet it's the
> volatile cast within the loop that's wrong; but I'm not sure how to do
> it correctly. Any help / pointers / discussion would be appreciated.

You need to cast is as dereferencing a volatile pointer.

Chris
