Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262050AbREYXky>; Fri, 25 May 2001 19:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262058AbREYXko>; Fri, 25 May 2001 19:40:44 -0400
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:21508 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S262050AbREYXkf>; Fri, 25 May 2001 19:40:35 -0400
Date: Fri, 25 May 2001 17:40:31 -0600
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.4-ac17 - missing in exports simple_strtol symbol 
Message-ID: <20010525174031.A7661@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patches to drivers/scsi/sg.c included in 2.4.4-ac17 require for
'sg.o' module to use 'simple_strtol' which is not exported in
kernel/ksyms.c.  Is this is an oversight or 'sg.o' should be actually
using something like 'simple_strtoul' - which is already exported?
In either case patches are obvious.

BTW - is tulip supposed to already work in this version?  Because
it does not.

  Michal
  michal@harddata.com
