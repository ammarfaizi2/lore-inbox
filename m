Return-Path: <linux-kernel-owner+w=401wt.eu-S1752809AbWLIUxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbWLIUxi (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 15:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753329AbWLIUxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 15:53:37 -0500
Received: from gate.crashing.org ([63.228.1.57]:40749 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752809AbWLIUxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 15:53:37 -0500
Subject: Re: sysfs file creation result nightmare (WAS radeonfb: Fix
	sysfs_create_bin_file warnings)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20061209202244.GH3545@rhun.ibm.com>
References: <20061209165606.2f026a6c.khali@linux-fr.org>
	 <1165694351.1103.133.camel@localhost.localdomain>
	 <20061209202244.GH3545@rhun.ibm.com>
Content-Type: text/plain
Date: Sun, 10 Dec 2006 07:53:17 +1100
Message-Id: <1165697597.1103.148.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-09 at 22:22 +0200, Muli Ben-Yehuda wrote:
> On Sun, Dec 10, 2006 at 06:59:10AM +1100, Benjamin Herrenschmidt wrote:
> 
> > I'd really like to have some kind of macro or attribute or whatever I
> > can put on a function call to say that I'm purposefully ignoring the
> > error. Is there some gcc magic that can do that ?
> 
> (void)bla()?

Do that actually work to silence the warning ? I though it didn't...I'll
try again.

Ben.

