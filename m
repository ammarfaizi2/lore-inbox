Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbTKTWyh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 17:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbTKTWyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 17:54:37 -0500
Received: from 217-124-44-255.dialup.nuria.telefonica-data.net ([217.124.44.255]:50560
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S263088AbTKTWx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 17:53:58 -0500
Date: Thu, 20 Nov 2003 23:53:54 +0100
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Voicu Liviu <pacman@mscc.huji.ac.il>, kerin@recruit2recruit.net
Subject: Re: 2.6.0-test9-mm4 (only) and vmware
Message-ID: <20031120225354.GB5094@localhost>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Voicu Liviu <pacman@mscc.huji.ac.il>,
	kerin@recruit2recruit.net
References: <3FBC917E.7090506@mscc.huji.ac.il> <20031120101830.GH22764@holomorphy.com> <3FBC9604.1020007@mscc.huji.ac.il> <20031120103117.GI22764@holomorphy.com> <3FBC996F.2060902@mscc.huji.ac.il> <20031120104220.GJ22764@holomorphy.com> <3FBC9C94.4030603@mscc.huji.ac.il> <20031120172059.GA22495@64m.dyndns.org> <20031120213810.GA5094@localhost> <20031120215536.GM22764@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120215536.GM22764@holomorphy.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 20 November 2003, at 13:55:36 -0800,
William Lee Irwin III wrote:

> Okay, several questions:
> (a) is _this_ run with 2.6.0-test9-mm4?
>
Yes, kernel version 2.6.0-test9-mm4.

> (b) which _exact_ fixes did you run with?
> 
I downloaded:
ftp://platan.vc.cvut.cz/pub/vmware/vmware-any-any-update45.tar.gz

I untarred it to /tmp and, as root, I run:
/tmp/vmware-any-any-update45/runme.pl

Then the script stopped VMware services, went to recompile both vmnet.o
and vmmon.o, and then started the services again.

Launched VMware as usual, tried to boot the same guest operating system
I used on yesterday's BUG report, and got the messages in the log.

What I am going to try now is to completely uninstall VMware, install it
from scratch and apply vmware-any-any-update45.tar.gz and see how it goes 
(to avoid previously applied patches or manual modifications to VMware
sources done by me making some difference).

Installed the VMware version shown above (via vmware-install.pl),
skipping the configuration part. Then I run "runme.pl" from the VMware
update version 45 to configure VMware and compile modules against my
current and configured 2.6.0-test9-mm4 kernel sources.

Started Vmware, tried to boot the guest operating system I have always
tried to boot during these tests and the result is the same as before,
including the BUG.

Hope this helps.

PS: just in case anyone sees it other way, I am just trying to help
giving information about a problem with a propietary application and
their binary only modules just in case this can unveil some sort of
kernel problem, but I am NOT trying to urge anyone to give me (us) a fix.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test9-mm4)
