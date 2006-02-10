Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWBJNNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWBJNNq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 08:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWBJNNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 08:13:46 -0500
Received: from boogie.lpds.sztaki.hu ([193.225.12.226]:64725 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S932080AbWBJNNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 08:13:45 -0500
Date: Fri, 10 Feb 2006 14:13:38 +0100
From: Gabor Gombas <gombasg@sztaki.hu>
To: Pavel Machek <pavel@suse.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Greg KH <greg@kroah.com>,
       linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Message-ID: <20060210131337.GD11740@boogie.lpds.sztaki.hu>
References: <20060208125753.GA25562@srcf.ucam.org> <20060208130422.GB25659@srcf.ucam.org> <20060208165803.GA15239@kroah.com> <20060208170857.GA29818@srcf.ucam.org> <20060209085344.GF16052@boogie.lpds.sztaki.hu> <20060210122131.GC4974@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060210122131.GC4974@elf.ucw.cz>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 01:21:31PM +0100, Pavel Machek wrote:

> Still "set current brightness" operation makes a lot of sense.

Yes, but userspace already knows if you are on AC power or not,
therefore it can decide what "current" means. If this is the only reason
then adding a new kernel infrastructure is overkill.

Also, doing things differently when on AC power smells like a policy
decision, and AFAIK policy handling is not wanted in the kernel.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences,
     Laboratory of Parallel and Distributed Systems
     Address   : H-1132 Budapest Victor Hugo u. 18-22. Hungary
     Phone/Fax : +36 1 329-78-64 (secretary)
     W3        : http://www.lpds.sztaki.hu
     ---------------------------------------------------------
