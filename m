Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280203AbRKSXav>; Mon, 19 Nov 2001 18:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280769AbRKSXal>; Mon, 19 Nov 2001 18:30:41 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:44619 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S280203AbRKSXae>; Mon, 19 Nov 2001 18:30:34 -0500
Date: Mon, 19 Nov 2001 18:30:33 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: linux-aio@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: aio-0.3.1.tar.gz
Message-ID: <20011119183032.C2190@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,

A new aio tarball including the -b patch of today which was just posted.  The 
notable highlights of this build include a test program for demonstrating 
the async poll functionality that people might find to be a better 
alternative to the /dev/*poll* patches, as well as fixes in the raw io side 
of things.  The tarball is available at:

	http://people.redhat.com/bcrl/aio/aio-0.3.1.tar.gz
	http://www.kvack.org/~bcrl/aio/aio-0.3.1.tar.gz

Prebuilt glibc RPMs are included in the same directory for users of Red 
Hat Linux on x86.  Please note that I'm in the middle of rewriting the 
networking code, so it's excluded at the moment; it should be ready 
shortly.  Any comments and feedback sent to linux-aio@kvack.org would be 
greatly appreciated!

		-ben

... ChangeLog ...
0.3.1
	- aio_poll operation is now tested and userland accessible
	- lots of little bugfixes for raw io and the aio core
	- make a NULL timeout to __io_getevents wait indefinately.
	- break out glibc patches from .src.rpm's and provide an 
	  rpm-less tarball.  should make life easier.

-- 
Fish.
