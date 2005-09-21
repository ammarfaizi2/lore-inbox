Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbVIUUuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbVIUUuP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 16:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbVIUUuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 16:50:15 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:57472 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S964818AbVIUUuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 16:50:12 -0400
Message-ID: <4331C772.7030906@nortel.com>
Date: Wed, 21 Sep 2005 14:49:54 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sonny Rao <sonny@burdell.org>
CC: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: dentry_cache using up all my zone normal memory -- also seen
 on 2.6.14-rc2
References: <433189B5.3030308@nortel.com> <43318FFA.4010706@nortel.com> <4331B89B.3080107@nortel.com> <20050921200758.GA25362@kevlar.burdell.org>
In-Reply-To: <20050921200758.GA25362@kevlar.burdell.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Sep 2005 20:50:04.0240 (UTC) FILETIME=[0AC98500:01C5BEEE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sonny Rao wrote:

> Just for kicks (again), have you tried ratcheting up the
> /proc/sys/vm/vfs_cache_pressure tunable by a few orders of magnitude ?

Boosting it up to 1000000 had no effect.

Chris
