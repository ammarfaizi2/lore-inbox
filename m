Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbVHSV15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbVHSV15 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 17:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbVHSV15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 17:27:57 -0400
Received: from mf00.sitadelle.com ([212.94.174.67]:24892 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S932302AbVHSV14
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 17:27:56 -0400
Message-ID: <43064ED1.40805@cosmosbay.com>
Date: Fri, 19 Aug 2005 23:27:45 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [RFC] f_maxcount seems to be deprecated ?
References: <20050819043331.7bc1f9a9.akpm@osdl.org>	<1124467911.9329.11.camel@kleikamp.austin.ibm.com> <20050819122122.0852de3a.akpm@osdl.org>
In-Reply-To: <20050819122122.0852de3a.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

Considering :

[root@dada1 linux-2.6.13-rc6]# find .|xargs grep f_maxcount
./fs/file_table.c:      f->f_maxcount = INT_MAX;
./fs/read_write.c:      if (unlikely(count > file->f_maxcount))
./include/linux/fs.h:   size_t                  f_maxcount;


I was wondering if f_maxcount has a real use these days...

Eric
