Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268071AbTAIWeg>; Thu, 9 Jan 2003 17:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268072AbTAIWeg>; Thu, 9 Jan 2003 17:34:36 -0500
Received: from [195.208.223.248] ([195.208.223.248]:12928 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S268071AbTAIWef>; Thu, 9 Jan 2003 17:34:35 -0500
Date: Fri, 10 Jan 2003 01:40:15 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Grant Grundler <grundler@cup.hp.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: Re: [patch 2.5] 2-pass PCI probing, generic part
Message-ID: <20030110014015.B693@localhost.park.msu.ru>
References: <1041942820.20658.2.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0301070942440.1913-100000@home.transmeta.com> <20030109204626.A2007@jurassic.park.msu.ru> <20030109195231.GB16698@cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030109195231.GB16698@cup.hp.com>; from grundler@cup.hp.com on Thu, Jan 09, 2003 at 11:52:31AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 11:52:31AM -0800, Grant Grundler wrote:
> Can the EXPORT_SYMBOL(pci_scan_bus) be removed now?

No, I think. Looks like it's used by ibm hotplug which can be a module.

Ivan.
