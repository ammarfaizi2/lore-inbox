Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261595AbTCTQSk>; Thu, 20 Mar 2003 11:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261597AbTCTQSk>; Thu, 20 Mar 2003 11:18:40 -0500
Received: from pat.uio.no ([129.240.130.16]:61924 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S261595AbTCTQSk>;
	Thu, 20 Mar 2003 11:18:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15993.60520.439204.267818@charged.uio.no>
Date: Thu, 20 Mar 2003 17:29:28 +0100
To: Vladimir Serov <vserov@infratel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] nfs client stuck in D state in linux 2.4.17 - 2.4.21-pre5
In-Reply-To: <3E79EAA8.4000907@infratel.com>
References: <20030318155731.1f60a55a.skraw@ithnet.com>
	<3E79EAA8.4000907@infratel.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Vladimir Serov <vserov@infratel.com> writes:

     > interrupt handler for NIC, it's gone !!!  IMHO this is due to
     > the race in the nfs client.

Why would an NFS race show up only on PPC? Do you have a tcpdump?

Cheers,
  Trond
