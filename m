Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWHOUqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWHOUqE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 16:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWHOUqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 16:46:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30434 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750725AbWHOUqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 16:46:01 -0400
Date: Tue, 15 Aug 2006 16:45:55 -0400
From: Bill Nottingham <notting@redhat.com>
To: Mitch Williams <mitch.a.williams@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: bonding: cannot remove certain named devices
Message-ID: <20060815204555.GB4434@nostromo.devel.redhat.com>
Mail-Followup-To: Mitch Williams <mitch.a.williams@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060815194856.GA3869@nostromo.devel.redhat.com> <Pine.CYG.4.58.0608151331220.3272@mawilli1-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0608151331220.3272@mawilli1-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mitch Williams (mitch.a.williams@intel.com) said: 
> Are spaces allowed in interface names anyway?  I can't believe that
> bonding is the only area affected by this.

They're certainly allowed, and the sysfs directory structure, files,
etc. handle it ok. Userspace tends to break in a variety of ways.

I believe the only invalid character in an interface name is '/'.

Bill
