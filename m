Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWCNNIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWCNNIm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 08:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWCNNIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 08:08:42 -0500
Received: from sainfoin.extra.cea.fr ([132.166.172.103]:745 "EHLO
	sainfoin.extra.cea.fr") by vger.kernel.org with ESMTP
	id S1751160AbWCNNIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 08:08:42 -0500
Message-Id: <200603141308.OAA25709@styx.bruyeres.cea.fr>
Date: Tue, 14 Mar 2006 14:07:54 +0100
From: Aurelien Degremont <aurelien.degremont@cea.fr>
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1 (X11/20050719)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: linux-kernel@vger.kernel.org
Subject: Re: /dev/stderr gets unlinked 8]
References: <200603141213.00077.vda@ilport.com.ua>
In-Reply-To: <200603141213.00077.vda@ilport.com.ua>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can I make /dev/stderr non-unlink-able?

Take a look to

$ man chattr
# chattr +i /dev/stderr

if you are using a ext2/3 filesystem. If not, maybe your filesystem has 
some similar functionality.

--
Aurelien Degremont
