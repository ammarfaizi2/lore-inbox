Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289657AbSBONl1>; Fri, 15 Feb 2002 08:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289631AbSBONlT>; Fri, 15 Feb 2002 08:41:19 -0500
Received: from web20513.mail.yahoo.com ([216.136.174.44]:38816 "HELO
	web20513.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289571AbSBONlI>; Fri, 15 Feb 2002 08:41:08 -0500
Message-ID: <20020215134107.46373.qmail@web20513.mail.yahoo.com>
Date: Fri, 15 Feb 2002 14:41:07 +0100 (CET)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: Linux 2.4.18-rc1
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo !

I just checked 2.4.18-rc1 on x86 with everything
(PIII/SMP/ACPI...).
I got 891 modules.
  - only tridentfb didn't compile ;
  - only wan/comx.o had an unresolved
    dependency (proc_get_inode).

At boot, the system hangs when displaying hda's
partitions : "<hda1> <hda2> <" *hang*
hda1 type is primary fat16 (6), hda2 is extended (5),
hda3 is primary linux (83).

At first I thought it came from all the partition
types I
had activated in "advanced partition selection", but
even when disabling it, it hangs. I'll try do disable
some
IDE options and filesystem types to see if it changes
something.

Regards,
Willy
PS: I can send the .config if someone wants.


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.fr
