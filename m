Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314082AbSDZR2B>; Fri, 26 Apr 2002 13:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314088AbSDZR2A>; Fri, 26 Apr 2002 13:28:00 -0400
Received: from B52e2.pppool.de ([213.7.82.226]:19984 "HELO Nicole.fhm.edu")
	by vger.kernel.org with SMTP id <S314082AbSDZR16>;
	Fri, 26 Apr 2002 13:27:58 -0400
Subject: UFS work
From: Daniel Egger <degger@fhm.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 26 Apr 2002 16:43:50 +0200
Message-Id: <1019832230.1366.4.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hija,

is anyone currently working on the UFS filesystem. I'd be really
interested in getting a stable support for read/write on OS X native
partitions; the current code is more than flaky in this regard in
the sense that it doesn't work at all:
- It allocates space for not written data
- It writes empty files into the directory
- It claims to be read-only after filecreation but still the above
  mentioned items apply.

-- 
Servus,
       Daniel

