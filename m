Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263062AbSJGOsk>; Mon, 7 Oct 2002 10:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263068AbSJGOsk>; Mon, 7 Oct 2002 10:48:40 -0400
Received: from pat.uio.no ([129.240.130.16]:54668 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S263062AbSJGOsj>;
	Mon, 7 Oct 2002 10:48:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15777.40984.140661.380868@charged.uio.no>
Date: Mon, 7 Oct 2002 16:54:16 +0200
To: David Howells <dhowells@cambridge.redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AFS filesystem for Linux (2/2) 
In-Reply-To: <14995.1034000047@warthog.cambridge.redhat.com>
References: <trond.myklebust@fys.uio.no>
	<15773.51748.415514.975150@charged.uio.no>
	<14995.1034000047@warthog.cambridge.redhat.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == David Howells <dhowells@cambridge.redhat.com> writes:

     > Does NFSv4 involve caching? If so, might working out a common
     > cache API be of use to you?

NFSv4 does not specify that files need to be backed by local storage
the way AFS does if that is what you mean. However it does offer
AFS-like features (such as file delegation / leases) that make a
cachefs a much more feasible proposition.

I, for one, would be very interested in seeing a cachefs add-on for
NFSv4. I think that it would be of great use for GRID / distributed
computation applications, which is where my personal interest in NFSv4
lies.

Cheers,
  Trond
