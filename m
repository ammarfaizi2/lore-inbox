Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291620AbSBTEEC>; Tue, 19 Feb 2002 23:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291625AbSBTEDv>; Tue, 19 Feb 2002 23:03:51 -0500
Received: from [194.46.8.33] ([194.46.8.33]:13331 "EHLO angusbay.vnl.com")
	by vger.kernel.org with ESMTP id <S291620AbSBTEDk>;
	Tue, 19 Feb 2002 23:03:40 -0500
Date: Wed, 20 Feb 2002 04:14:13 +0000
From: Dale Amon <amon@vnl.com>
To: linux-kernel@vger.kernel.org
Subject: make install doesn't work for kernel factories
Message-ID: <20020220041413.GC29004@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following does not work:

	make DESTDIR=/my/target/root install

it calls 

exec /sbin/installkernel 2.4.17 bzImage /my/source/directory/linux-2.4.17/System.map

and proceeds to drop it on top of the local machine's 
kernel. installkernel should honor the selection of
a different root.

-- 
------------------------------------------------------
    Nuke bin Laden:           Dale Amon, CEO/MD
  improve the global          Islandone Society
     gene pool.               www.islandone.org
------------------------------------------------------
