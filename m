Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268378AbUJDTGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268378AbUJDTGZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 15:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268000AbUJDTFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 15:05:34 -0400
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:22656
	"HELO home.linuxace.com") by vger.kernel.org with SMTP
	id S268458AbUJDTA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 15:00:57 -0400
Date: Mon, 4 Oct 2004 12:00:54 -0700
From: Phil Oester <kernel@linuxace.com>
To: linux-kernel@vger.kernel.org
Subject: Process start times moving in reverse on 2.6.8.1
Message-ID: <20041004190054.GA29409@linuxace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ISTR discussion on the mailing list about this problem,
and recently upgraded from 2.6.3 to 2.6.8.1 to hopefully
solve it, but alas the problem still exists.

Example:

# date ; ps -ef | grep ps | grep -v grep
Mon Oct  4 14:53:39 EDT 2004
root     29412 29351  0 14:51 pts/0    00:00:00 ps -ef

Notice the two minute difference between now and what the
process start time is.  Uptime on this box is 48 days, so
it is a gradual drift.

Any ideas on this?  Or has it been fixed since 2.6.8.1?

Phil

