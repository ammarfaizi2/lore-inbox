Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWDEQr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWDEQr0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 12:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWDEQr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 12:47:26 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:28546 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751269AbWDEQr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 12:47:26 -0400
Message-ID: <4433F497.9090704@zabbo.net>
Date: Wed, 05 Apr 2006 09:47:19 -0700
From: Zach Brown <zab@zabbo.net>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: yzy <yzy@clusterfs.com>, linux-kernel@vger.kernel.org, eeb@clusterfs.com,
       green@clusterfs.com
Subject: Re: Here is the tcp-zero-copy patch for kernel 2.6.12-6 .
References: <44336CC0.6030206@clusterfs.com> <4433DCAF.5060503@garzik.org>
In-Reply-To: <4433DCAF.5060503@garzik.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 1) Why, we already have zero-copy?

It's poorly named.  The sendpage side is so that Lustre's in-kernel
'tcpnal' can get callbacks when an skb tx is completed.  I don't know
what the recvpackets thing is for.

It certainly doesn't look like something that will be merged.
(duplicate code, nutty style, questionable double callback registration,
etc)

- z
