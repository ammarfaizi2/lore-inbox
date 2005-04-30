Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263101AbVD3At5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbVD3At5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 20:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263098AbVD3At4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 20:49:56 -0400
Received: from smtp.istop.com ([66.11.167.126]:6272 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S263101AbVD3Atl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 20:49:41 -0400
From: Daniel Phillips <phillips@istop.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
Subject: Re: [PATCH 1a/7] dlm: core locking
Date: Fri, 29 Apr 2005 20:50:29 -0400
User-Agent: KMail/1.7
Cc: Joel Becker <Joel.Becker@oracle.com>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       David Teigland <teigland@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <20050425165705.GA11938@redhat.com> <200504290410.13271.phillips@istop.com> <20050429215221.GC355@ca-server1.us.oracle.com>
In-Reply-To: <20050429215221.GC355@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504292050.29851.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 April 2005 17:52, Mark Fasheh wrote:
> * Without LKM_LOCAL:
> [root@ca-test7 ocfs2]# time tar -zxf /tmp/linux-2.6.11.7.tar.gz
>
> real    0m39.699s
> user    0m3.644s
> sys     0m8.076s
>
> * With LKM_LOCAL
> [root@ca-test7 ocfs2]# time tar -zxf /tmp/linux-2.6.11.7.tar.gz
>
> real    0m22.076s
> user    0m3.869s
> sys     0m7.234s
>
> So yes, I'd say it's worth a significant amount of performance to us :)

To be precise, LKM_LOCAL saves you 44%, and even without LKM_LOCAL you turn in 
a respectable number.  Could you please provide your node, shared disk and 
network specs?

Because I am greedy, I would like to have seen the Ext3 number, too.  And oh 
yes, the Ext2 number!

Regards,

Daniel
