Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbVIUVZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbVIUVZZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 17:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbVIUVZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 17:25:25 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:55686 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S964945AbVIUVZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 17:25:24 -0400
Message-ID: <4331CFAD.6020805@nortel.com>
Date: Wed, 21 Sep 2005 15:25:01 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: Sonny Rao <sonny@burdell.org>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>, bharata@in.ibm.com,
       viro@ftp.linux.org.uk, trond.myklebust@fys.uio.no
Subject: Re: dentry_cache using up all my zone normal memory -- also seen
 on 2.6.14-rc2
References: <433189B5.3030308@nortel.com> <43318FFA.4010706@nortel.com> <4331B89B.3080107@nortel.com> <20050921200758.GA25362@kevlar.burdell.org> <4331C9B2.5070801@nortel.com> <20050921210019.GF4569@in.ibm.com>
In-Reply-To: <20050921210019.GF4569@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Sep 2005 21:25:11.0414 (UTC) FILETIME=[F2C2C160:01C5BEF2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:

> Does this happen on a non-nfs filesystem ?

Digging in a bit more, it looks like the files are being 
created/destroyed/renamed in /tmp, which is a tmpfs filesystem.

Chris
