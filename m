Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262953AbSJBDnA>; Tue, 1 Oct 2002 23:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262954AbSJBDnA>; Tue, 1 Oct 2002 23:43:00 -0400
Received: from 12-234-33-29.client.attbi.com ([12.234.33.29]:49734 "HELO
	laura.worldcontrol.com") by vger.kernel.org with SMTP
	id <S262953AbSJBDnA>; Tue, 1 Oct 2002 23:43:00 -0400
From: brian@worldcontrol.com
Date: Tue, 1 Oct 2002 20:48:25 -0700
To: linux-kernel@vger.kernel.org
Subject: swsusp 2.4.18 vs 2.5.40
Message-ID: <20021002034825.GA1892@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Litzinger writes:

>[swsusp in 2.4.18 works pretty well but...]

Pavel Machek <pavel@suse.cz> writes:

>Yep, swsusp is not really meant to work in 2.4.X. Get latest 2.5.X...  
>and add IDE patches so it does not eat your disk...                    

Ok, I've compiled and tried 2.5.40.

Zip. Nada. swsusp doesn't show up at all.  If I compile with SMP
turned on I get a message about swsusp being incompatible with
SMP.  Running UP it doesn't show up in the boot log, though it
looks to be compiled.

It also doesn't show in the SysRq help list.

echo'ing things to /proc/acpi/sleep does nothing.

-- 
Brian Litzinger
