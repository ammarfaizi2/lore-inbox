Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278587AbRJ1RLe>; Sun, 28 Oct 2001 12:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278590AbRJ1RLZ>; Sun, 28 Oct 2001 12:11:25 -0500
Received: from dibbler.ne.mediaone.net ([24.218.57.139]:55956 "EHLO
	dibbler.ne.mediaone.net") by vger.kernel.org with ESMTP
	id <S278589AbRJ1RLI>; Sun, 28 Oct 2001 12:11:08 -0500
Date: Sun, 28 Oct 2001 12:11:38 -0500
From: Craig Rodrigues <rodrigc@mediaone.net>
To: linux-kernel@vger.kernel.org
Cc: gcc@gcc.gnu.org
Subject: gcc 3.0.2 problems compiling Linux kernel
Message-ID: <20011028121138.A24899@mediaone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The two following bug reports in the GCC GNATS system describe
problems compiling parts of the Linux kernel with gcc 3.0.2:

http://gcc.gnu.org/cgi-bin/gnatsweb.pl?pr=4529&cmd=view&database=gcc
http://gcc.gnu.org/cgi-bin/gnatsweb.pl?pr=4059&cmd=view&database=gcc
(Login: guest, PW: guest)

The problem seems to disappear if the -fomit-frame-pointer
flag is not used for compiling the problematic files in the
kernel.

Can anyone with kernel and/or compiler internals knowledge shed 
some light on what the possible problem is in either the
kernel or in gcc, and what the fix to either would be?

Thanks. 
-- 
Craig Rodrigues        
http://www.gis.net/~craigr    
rodrigc@mediaone.net          
