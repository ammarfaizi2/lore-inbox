Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbUKVXfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbUKVXfn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 18:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbUKVXfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:35:25 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:34274 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262441AbUKVXen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:34:43 -0500
Message-ID: <41A27784.70505@sgi.com>
Date: Mon, 22 Nov 2004 17:34:28 -0600
From: Eric Sandeen <sandeen@sgi.com>
User-Agent: Mozilla Thunderbird 0.9 (Macintosh/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan De Luyck <lkml@kcore.org>
CC: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [2.6.10-rc2] XFS filesystem corruption
References: <200411221530.30325.lkml@kcore.org>
In-Reply-To: <200411221530.30325.lkml@kcore.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The trigger was a bad magic number related to directories... hard to say 
what happened in the first place.  Can you send the output from 
xfs_repair, that might offer some hints.

Thanks,

-Eric
