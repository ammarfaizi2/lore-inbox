Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264232AbRFMCKc>; Tue, 12 Jun 2001 22:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264278AbRFMCKM>; Tue, 12 Jun 2001 22:10:12 -0400
Received: from tisch.mail.mindspring.net ([207.69.200.157]:50234 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S264232AbRFMCKD>; Tue, 12 Jun 2001 22:10:03 -0400
Subject: Re: double entries in /proc/dri?
From: Robert Love <rml@tech9.net>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010612185603.A2031@work.bitmover.com>
In-Reply-To: <20010612185603.A2031@work.bitmover.com>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 12 Jun 2001 22:10:05 -0400
Message-Id: <992398207.5272.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Jun 2001 18:56:03 -0700, Larry McVoy wrote:
><snip>
>    4106 -r--r--r--    1 root     root            0 Jun 12 18:53 dma
>    4347 dr-xr-xr-x    3 root     root            0 Jun 12 18:53 dri
>    4347 dr-xr-xr-x    3 root     root            0 Jun 12 18:53 dri
>    4121 dr-xr-xr-x    2 root     root            0 Jun 12 18:53 driver
><snip>

not here, but this is 2.4.5-ac13.

[22:07:35]rml@phantasy:/proc# ls -li
   ...
   4106 -r--r--r--    1 root     root            0 Jun 12 22:07 dma
   4300 dr-xr-xr-x    3 root     root            0 Jun 12 22:07 dri
   4121 dr-xr-xr-x    2 root     root            0 Jun 12 22:07 driver
   ...

[22:09:13]rml@phantasy:/proc# cat /proc/version 
Linux version 2.4.5-ac13 (rml@phantasy) (gcc version 2.96 20000731 (Red
Hat Linux 7.1 2.96-85)) #1 Sun Jun 10 17:34:02 EDT 2001

either fixed in an -ac release, or not a universal bug?

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

