Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWEVLeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWEVLeP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 07:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWEVLeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 07:34:14 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48815 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750760AbWEVLeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 07:34:14 -0400
Subject: Re: [PATCH] namespaces: uts_ns: make information visible via
	/proc/PID/uts directory
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sam Vilain <sam@vilain.net>
Cc: linux-kernel@vger.kernel.org, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, ebiederm@xmission.com, xemul@sw.ru,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Cedric Le Goater <clg@fr.ibm.com>, serue@us.ibm.com
In-Reply-To: <20060522052425.27715.94562.stgit@localhost.localdomain>
References: <20060522052425.27715.94562.stgit@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 22 May 2006 12:45:18 +0100
Message-Id: <1148298318.17376.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-05-22 at 17:24 +1200, Sam Vilain wrote:
> From: Sam Vilain <sam.vilain@catalyst.net.nz>
> 
> Export the UTS information to a per-process directory /proc/PID/uts,
> that has individual nodes for hostname, ostype, etc - similar to
> those in /proc/sys/kernel

Can you explain the locking being used here against the name being
changed at the same moment ?


