Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265736AbUADQDJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 11:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265726AbUADQDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 11:03:09 -0500
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:22421 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S265736AbUADQCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 11:02:54 -0500
Message-ID: <3FF83921.1030907@backtobasicsmgmt.com>
Date: Sun, 04 Jan 2004 09:02:41 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Witukind <witukind@nsbm.kicks-ass.org>,
       "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: udev - please help me to understand
References: <microsoft-free.87r7yiinaj.fsf@eicq.dnsalias.org> <20040102202316.GD4992@kroah.com> <20040103010010.GA14823@werewolf.able.es> <20040103135433.09eb97b7.witukind@nsbm.kicks-ass.org> <20040103215646.GE11061@kroah.com>
In-Reply-To: <20040103215646.GE11061@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> procfs is for process information.
> sysfs is for system information.  Slowly, over time, things that are
> currently in procfs will be moving to sysfs.

Slight clarification:

Slowly, over time, things that are currently in procfs _that never 
belonged there_ will be moving to sysfs. procfs isn't going away, it's 
just being converted back to its original purpose (that of providing 
process-specific information).

