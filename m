Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTEHR07 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 13:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbTEHR07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 13:26:59 -0400
Received: from holomorphy.com ([66.224.33.161]:37017 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261895AbTEHR06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 13:26:58 -0400
Date: Thu, 8 May 2003 10:39:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
Message-ID: <20030508173926.GO8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Helge Hafting <helgehaf@aitel.hist.no>, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org
References: <20030507144100.GD8978@holomorphy.com> <20030507.064010.42794250.davem@redhat.com> <20030507215430.GA1109@hh.idb.hist.no> <20030508013854.GW8931@holomorphy.com> <20030508065440.GA1890@hh.idb.hist.no> <20030508080135.GK8978@holomorphy.com> <20030508100717.GN8978@holomorphy.com> <3EBA4529.7050507@aitel.hist.no> <20030508120450.GT823@suse.de> <20030508133908.GA824@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508133908.GA824@hh.idb.hist.no>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08 2003, Helge Hafting wrote:
>>> 2.5.69-mm3 died in exactly the same way - the oops was identical.
>>> I'm back to running mm2 without netfilter, to see how
>>> stable it is.

On Thu, May 08, 2003 at 02:04:50PM +0200, Jens Axboe wrote:
>> See my mail to rusty, I'm seeing the same thing. Back out the changeset
>> that wli pasted here too, and it will work.

On Thu, May 08, 2003 at 03:39:08PM +0200, Helge Hafting wrote:
> Much fuzz and two rejects.  Seems there is ongoing netfilter
> work in mm3.

This is fine for my purposes; we narrowed down the cause to the current
netfilter issue (and exonerated what I'd otherwise have to fix) so all
is well.

It sounds like the fix for the issue merged in -mm3 was incomplete. It
should get straightened out soon.


-- wli
