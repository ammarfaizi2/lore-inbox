Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266219AbUFPIiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266219AbUFPIiJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 04:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266218AbUFPIiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 04:38:08 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:38882 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S266237AbUFPIhw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 04:37:52 -0400
Message-ID: <40D006BF.7020002@cosmosbay.com>
Date: Wed, 16 Jun 2004 10:37:19 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: bert hubert <ahu@ds9a.nl>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [DOCUMENTATION PATCH] Missing net sysctls, some fixed, rest flagged
References: <20040609175242.GA13875@outpost.ds9a.nl> <20040615201912.691ffe35.davem@redhat.com>
In-Reply-To: <20040615201912.691ffe35.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>+somaxconn - INTEGER
>+	Limit of TCP listen backlog, known in userspace as SOMAXCONN.
>+	Defaults to 128
>+
>  
>
Hmm...

I dont agree with the 'TCP' word here : listen() system call is not tied 
with TCP, isn't it ?
I would suggest :

+somaxconn - INTEGER
+	Limit of socket listen() backlog, known in userspace as SOMAXCONN.
+	Defaults to 128. See also tcp_max_syn_backlog for additional tuning for TCP sockets.
+


Thank you

Eric Dumazet

