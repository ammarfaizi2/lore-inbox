Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318766AbSHWLRr>; Fri, 23 Aug 2002 07:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318767AbSHWLRr>; Fri, 23 Aug 2002 07:17:47 -0400
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:10956 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S318766AbSHWLRr>; Fri, 23 Aug 2002 07:17:47 -0400
Date: Fri, 23 Aug 2002 07:26:01 -0400
To: dledford@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.31 qlogic error "this should not happen"
Message-ID: <20020823112601.GA6796@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Try applying the attached patch and see if it helps you out any.

The box locked up while running bonnie++ with the patch.
One difference was without the patch, it printed the
"this should not happen" 9 times.  With the patch, it printed
54 times (6 times more), if that's any kind of clue.

I'm trying Eric's suggestion to change QLOGICFC_REQ_QUEUE_LEN
from 127 to 255 on top of your patch.

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

