Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264505AbUFSXB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbUFSXB1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 19:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264762AbUFSXB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 19:01:26 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:59840 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264505AbUFSXBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 19:01:24 -0400
Date: Sun, 20 Jun 2004 00:00:11 +0100
From: Dave Jones <davej@redhat.com>
To: matthew-lkml@newtoncomputing.co.uk
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stop printk printing non-printable chars
Message-ID: <20040619230010.GA16841@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	matthew-lkml@newtoncomputing.co.uk, Jesper Juhl <juhl-lkml@dif.dk>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <20040618205355.GA5286@newtoncomputing.co.uk> <Pine.LNX.4.58.0406181407330.6178@ppc970.osdl.org> <Pine.LNX.4.56.0406190032290.17899@jjulnx.backbone.dif.dk> <20040618235223.GB5286@newtoncomputing.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040618235223.GB5286@newtoncomputing.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2004 at 12:52:23AM +0100, matthew-lkml@newtoncomputing.co.uk wrote:

 > I must admit, I don't think I've even seen a tab before (not that you'd
 > actually _see_ a tab). Oh, grep tells me that powernow uses it. By the
 > time that gets through syslog it's changed into "^I", so it would
 > probably be better to not actually use tabs, either (or fix syslog).

I've been meaning to fix that for a while, and kept forgetting
about it.  I just fixed it in my local cpufreq tree, and will
push it along with the next lot of updates.

Thanks,

		Dave

