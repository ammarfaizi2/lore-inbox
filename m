Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTFJJGp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 05:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbTFJJGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 05:06:45 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:42405 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262482AbTFJJGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 05:06:44 -0400
Date: Tue, 10 Jun 2003 10:20:17 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Oleg Drokin <green@namesys.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 / reiserfs data corruption, 2.5-bk
Message-ID: <20030610092017.GA24203@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Oleg Drokin <green@namesys.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030609193541.GA21106@suse.de> <20030610084323.GA16435@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030610084323.GA16435@namesys.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10, 2003 at 12:43:23PM +0400, Oleg Drokin wrote:

 > > 2.5 Bitkeeper tree as of last 24 hrs. Running a lot
 > > of disk IO stress (multiple fsstress, over 100 fsx instances,
 > > and random sync calling) produced failures on both reiserfs
 > > and ext3.
 > > Tests were done on seperate disks, but concurrently.
 > 
 > Do you have smp or preempt enabled?

# CONFIG_SMP is not set
CONFIG_PREEMPT=y

		Dave

