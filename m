Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBJUgu>; Sat, 10 Feb 2001 15:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129143AbRBJUgk>; Sat, 10 Feb 2001 15:36:40 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:64260 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S129142AbRBJUga>; Sat, 10 Feb 2001 15:36:30 -0500
Message-ID: <3A85A5EC.EFE3F703@sgi.com>
Date: Sat, 10 Feb 2001 12:34:52 -0800
From: LA Walsh <law@sgi.com>
Organization: Trust Technology, SGI
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.2-pre1 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: question on comment in fs.h
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excuse my ignorance, but in file include/linux/fs.h, 2.4.x source
in the struct buffer_head, there is a member:
	unsigned short b_size;          /* block size */    
later there is a member:
	char * b_data;                  /* pointer to data block (512 byte) */ 

Is the "(512 byte)" part of the comment in error or do I misunderstand
the nature of 'b_size'

-l

-- 
Linda A Walsh                    | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
