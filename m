Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264176AbUD0QEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264176AbUD0QEp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 12:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264197AbUD0QEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 12:04:45 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:59842 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264176AbUD0QEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 12:04:44 -0400
Date: Tue, 27 Apr 2004 18:02:05 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Timothy Miller <miller@techsource.com>
Cc: Paul Jackson <pj@sgi.com>, root@chaos.analogic.com,
       joelja@darkwing.uoregon.edu, tytso@mit.edu, miquels@cistron.nl,
       linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
Message-ID: <20040427160205.GA2176@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0404231300470.27087-100000@twin.uoregon.edu> <Pine.LNX.4.53.0404231624010.1352@chaos> <20040423163420.43f55a90.pj@sgi.com> <408E7F53.5010602@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <408E7F53.5010602@techsource.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 April 2004 11:42:11 -0400, Timothy Miller wrote:
> Paul Jackson wrote:
> 
> >To heck with disk compression - it's time for main memory compression.
> 
> I think nVidia and ATI chips do that with the Z buffer.  Definately 
> improves bandwidth utilization.
           ^^^^^^^^^

Well stated.  For general purpose cpus with unpredictable access
patterns, compression makes latency even worse, so you need even
bigger caches.

On the other hand, memory compression makes memory bigger, and memory
of course is a disk cache, so it does improve latency somewhere.

Jörn

-- 
Victory in war is not repetitious.
-- Sun Tzu
