Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271930AbRHVFWQ>; Wed, 22 Aug 2001 01:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271931AbRHVFWG>; Wed, 22 Aug 2001 01:22:06 -0400
Received: from adsl-63-196-157-142.dsl.lsan03.pacbell.net ([63.196.157.142]:57359
	"HELO adsl-63-196-157-142.dsl.lsan03.pacbell.net") by vger.kernel.org
	with SMTP id <S271930AbRHVFWB>; Wed, 22 Aug 2001 01:22:01 -0400
Date: Tue, 21 Aug 2001 22:10:47 -0700
From: try <try@lyang.net>
To: linux-kernel@vger.kernel.org
Cc: try@lyang.net
Subject: i686 binary executes on i586?
Message-ID: <20010821221047.A30977@box.lyang.net>
Reply-To: try@neasys.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have compiled 'chown' (in fileutils, statically linked and stripped)
on an i686 box and tried to run it on i586 box.
I need to understand why
this one fails:

root:/# /bin/chown root:daemon try 
Illegal instruction (core dumped)

but this one succeed:
root:/# /bin/chown root:root try

Also, in general, how can I tell an i686 binary from
an i586 binary (or lower). Tool /usr/bin/file does
not help much.

Thanks,

-T
