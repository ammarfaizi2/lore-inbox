Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261347AbRE2OJ4>; Tue, 29 May 2001 10:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbRE2OJq>; Tue, 29 May 2001 10:09:46 -0400
Received: from pat.uio.no ([129.240.130.16]:62460 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S261347AbRE2OJm>;
	Tue, 29 May 2001 10:09:42 -0400
To: dobos_s@IBCnet.hu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 locks up on SMP - tcp-hang patch NOT fixed the problem!
In-Reply-To: <OF56FACC45.D8F8889E-ONC1256A5B.004A7C70@ibcnet.hu>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 29 May 2001 16:08:10 +0200
In-Reply-To: dobos_s@IBCnet.hu's message of "Tue, 29 May 2001 15:50:22 +0200"
Message-ID: <shsitikmenp.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == dobos s <dobos_s@IBCnet.hu> writes:

     > I have the problem.  As I read mails between Alan, Ioan and
     > Trond on the above subject I decided to try Trond's tcp-hang
     > patch to see It really solves the problem.

     > I dont think so. In my source tree there are not compiled files
     > in net/sunrpc dir, and CONFIG_SUNRPC is not set in my .config!

That patch was only meant to fix a hang in NFS and friends. It's
doesn't fix anything in the generic TCP code.

Cheers,
   Trond
