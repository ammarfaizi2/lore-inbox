Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317181AbSGNWFI>; Sun, 14 Jul 2002 18:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317182AbSGNWFH>; Sun, 14 Jul 2002 18:05:07 -0400
Received: from esteel10.client.dti.net ([209.73.14.10]:10184 "EHLO
	shookay.newview.com") by vger.kernel.org with ESMTP
	id <S317181AbSGNWFG>; Sun, 14 Jul 2002 18:05:06 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
References: <200207142004.g6EK4LaV019433@burner.fokus.gmd.de>
	<xltbs9aj9w9.fsf@shookay.newview.com>
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
Date: 14 Jul 2002 18:07:53 -0400
In-Reply-To: <xltbs9aj9w9.fsf@shookay.newview.com>
Message-ID: <xlt1ya6j746.fsf@shookay.newview.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mathieu@newview.com (Mathieu Chouquet-Stringer) writes:
> Well, to be frank, I wouldn't blame the scsi subsystem: the disk is almost
> idle and procinfo -d gives an average of 6 irqs (using the default 5 sec
> delay between 2 updates)...

As promised, here is the final result (even if we know it's a fs issue):

mchouque - /tmp/joerg %/usr/bin/time tar jxf rock.tar.bz2
19.69user 6796.49system 1:56:05elapsed 97%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (319major+951minor)pagefaults 0swaps
/usr/bin/time tar jxf rock.tar.bz2  19.69s user 6796.49s system 97% cpu 1:56:05.11 total

-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
    It is exactly because a man cannot do a thing that he is a
                      proper judge of it.
                      -- Oscar Wilde
