Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132999AbRDYXWB>; Wed, 25 Apr 2001 19:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133004AbRDYXVw>; Wed, 25 Apr 2001 19:21:52 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:16088 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S132999AbRDYXVd>; Wed, 25 Apr 2001 19:21:33 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDDDD2@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>
Subject: down_timeout
Date: Wed, 25 Apr 2001 16:21:22 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems like we need to implement down_timeout (and
down_timeout_interruptible) to fully flesh out the semaphore implementation.
It is difficult and inefficient to emulate this using wrapper functions, as
far as I can see.

Seems like this is a fairly standard interface to have for OS semaphores. We
have a prototype implementation, and could contribute this, if desired.

Thoughts?

Regards -- Andy

