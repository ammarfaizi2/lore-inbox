Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285724AbRLTAxT>; Wed, 19 Dec 2001 19:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285745AbRLTAxK>; Wed, 19 Dec 2001 19:53:10 -0500
Received: from pat.uio.no ([129.240.130.16]:62688 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S285738AbRLTAw7>;
	Wed, 19 Dec 2001 19:52:59 -0500
To: David Chow <davidchow@rcn.com.hk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: nfsroot dead slow with redhat 7.2
In-Reply-To: <3C2131FC.6040209@rcn.com.hk>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 20 Dec 2001 01:52:42 +0100
In-Reply-To: <3C2131FC.6040209@rcn.com.hk>
Message-ID: <shs6672n25h.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == David Chow <davidchow@rcn.com.hk> writes:

     > Dear all, When I use 2.4.7-10 i686 kernel from stock Redhat 7.2
     > as the NFS server. My NFS client use the 2.4.13 kernel, when I
     > mount the nfsroot to the server, I found it is dead slow on the
     > client. This only happens in i686 kernel on the server, if we
     > use a K6-2 uses an i386 server its fine. What's going on? By

Usually means you have a bad network connection. Use tcpdump to
isolate where on the network packets (and UDP fragments) are
disappearing.

     > the way, how to configure the client to default use a NFSv3
     > mount? Thanks.

Specify the 'v3' NFSroot mount option.

Cheers,
   Trond
