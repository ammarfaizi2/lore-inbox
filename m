Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288867AbSATSEH>; Sun, 20 Jan 2002 13:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288870AbSATSD5>; Sun, 20 Jan 2002 13:03:57 -0500
Received: from pat.uio.no ([129.240.130.16]:37507 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S288867AbSATSDn>;
	Sun, 20 Jan 2002 13:03:43 -0500
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] with 2.4.18-pre4+linux-2.4.18-NFS_ALL
In-Reply-To: <20020120164118.D587513E3@shrek.lisa.de>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 20 Jan 2002 19:03:14 +0100
In-Reply-To: <20020120164118.D587513E3@shrek.lisa.de>
Message-ID: <shsbsfo6gt9.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Hans-Peter Jansen <hpj@urpla.net> writes:

     > Hi Trond et al., I can reliably reproduce this oops on my
     > diskless with NFS_ALL applied, but not with plain-pre4, just by
     > quitting one of {StarOffice,VMware}.

The new version should be rid of it. It was a call to get_file() which
was missing a test for a NULL argument.

Cheers,
  Trond
