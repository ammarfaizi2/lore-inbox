Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285357AbRLNMnX>; Fri, 14 Dec 2001 07:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285358AbRLNMnN>; Fri, 14 Dec 2001 07:43:13 -0500
Received: from pat.uio.no ([129.240.130.16]:60604 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S285357AbRLNMm6>;
	Fri, 14 Dec 2001 07:42:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15385.62404.979513.357633@charged.uio.no>
Date: Fri, 14 Dec 2001 13:42:44 +0100
To: dzafman@kahuna.cag.cpqcorp.net
Cc: linux-kernel@vger.kernel.org
Subject: NFS client llseek
In-Reply-To: <200112140057.fBE0vDm05648@kahuna.cag.cpqcorp.net>
In-Reply-To: <200112140057.fBE0vDm05648@kahuna.cag.cpqcorp.net>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == dzafman  <dzafman@kahuna.cag.cpqcorp.net> writes:

     > I noticed that generic_file_llseek looks at i_size without
     > performing a revalidate, so I propose the following patch for
     > NFS client.  It applies to both 2.4.16 and 2.5.0 kernels.

Good point.

Thanks,
   Trond
