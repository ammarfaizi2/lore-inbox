Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266085AbUFPDXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266085AbUFPDXE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 23:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266100AbUFPDXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 23:23:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38538 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266085AbUFPDXC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 23:23:02 -0400
Message-ID: <40CFBD04.8030601@pobox.com>
Date: Tue, 15 Jun 2004 23:22:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Morris <jmorris@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [SELINUX][PATCH 1/4] Fine-grained Netlink support - SELinux headers
 update
References: <Xine.LNX.4.44.0406152226150.30562-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0406152226150.30562-100000@thoron.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:
> This patch regenerates the SELinux module headers to reflect new class
> and access vectors definitions.  The size of the diff is misleading;
> much of it is simply a change in the ordering of the automatically
> generated definitions. The corresponding generation script has been
> changed to ensure a stable order in the future.  Please apply.


Why not commit the generation script, and kill the auto-generated files?

	Jeff


