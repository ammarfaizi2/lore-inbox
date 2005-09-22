Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbVIVSMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbVIVSMm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 14:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbVIVSMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 14:12:42 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:19422 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1750943AbVIVSMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 14:12:42 -0400
Message-ID: <4332F409.7010608@nortel.com>
Date: Thu, 22 Sep 2005 12:12:25 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Roland Dreier <rolandd@cisco.com>, dipankar@in.ibm.com,
       Sonny Rao <sonny@burdell.org>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>, bharata@in.ibm.com,
       trond.myklebust@fys.uio.no
Subject: Re: dentry_cache using up all my zone normal memory -- new data point
References: <433189B5.3030308@nortel.com> <43318FFA.4010706@nortel.com> <4331B89B.3080107@nortel.com> <20050921200758.GA25362@kevlar.burdell.org> <4331C9B2.5070801@nortel.com> <20050921210019.GF4569@in.ibm.com> <4331CFAD.6020805@nortel.com> <52ll1qkrii.fsf@cisco.com> <20050922031136.GE7992@ftp.linux.org.uk> <43322AE6.1080408@nortel.com> <20050922041733.GF7992@ftp.linux.org.uk> <4332CAEA.1010509@nortel.com>
In-Reply-To: <4332CAEA.1010509@nortel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Sep 2005 18:12:33.0469 (UTC) FILETIME=[341A0ED0:01C5BFA1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I don't know if this will help, but I re-ran the test with our modified 
2.6.10 on a dual-xeon, and the dentry cache stays around 600-700KB the 
whole time.

Chris
