Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267180AbTBXObp>; Mon, 24 Feb 2003 09:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267183AbTBXObp>; Mon, 24 Feb 2003 09:31:45 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:35338 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267180AbTBXObn>; Mon, 24 Feb 2003 09:31:43 -0500
Date: Mon, 24 Feb 2003 14:41:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] interesting new vendor kernels on kernelnewbies.org
Message-ID: <20030224144156.A6319@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to annouce that there are two new interesting vendor kernels
available on the kernelnewbies vendor kernels page
(http://www.kernelnewbies.org/kernels/).  Both unfortunately don't use
the traditional organization of multiple pathes agains ta base kernel
release but were tarballs that I had to diff against known kernel release.

In detail they are:

(1) The NEC kernel for their IA64 machines.

    Interestng here are their VM changes and a NFS extension for shared
    storage called GFS (it's different from Sistina's filesystem of the same name)

(2) The kernel from TimeSys 3.1 demo release

    This one is really interesting, it features a completly new scheduler
    architectured around hooks to their propritary real time kernel and
    heavyweight mutexes (e.g. with priority inheritance) that replace Linux
    spinlocks.  These architecture probably violates the GPL, but I'd like
    to hear some more opinions on people who actually read the code before
    bothering TimeSys about this issue.
