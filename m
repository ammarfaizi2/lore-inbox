Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312255AbSDFTmx>; Sat, 6 Apr 2002 14:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312564AbSDFTmw>; Sat, 6 Apr 2002 14:42:52 -0500
Received: from 12-234-33-29.client.attbi.com ([12.234.33.29]:2628 "HELO
	top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S312255AbSDFTmw>; Sat, 6 Apr 2002 14:42:52 -0500
From: brian@worldcontrol.com
Date: Sat, 6 Apr 2002 11:31:57 -0800
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre6 swsusp problems (vs. 2.4.19pre5ac3)
Message-ID: <20020406193157.GA3339@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Indeed the swsusp in -ac seems to oops a lot.  I hand patched
swsusp v0.8 to work with 2.4.19pre6 and get better behavior.

The docs (config help for swsusp) imply you don't need APM.
However turning APM entirely off results in compile errors
in swsusp.c.

Turning APM mostly off, results in swsusp reporting that it
can't stop kapmd.

-- 
Brian Litzinger <brian@worldcontrol.com>
