Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbTJIAyN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 20:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTJIAyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 20:54:13 -0400
Received: from mail.skjellin.no ([80.239.42.67]:64430 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S261856AbTJIAyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 20:54:12 -0400
Subject: Re: Software RAID5 with 2.6.0-test
From: Andre Tomt <andre@tomt.net>
To: linux-kernel@vger.kernel.org
Cc: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
In-Reply-To: <yw1xad8bfg6q.fsf@users.sourceforge.net>
References: <yw1xoewrfizk.fsf@users.sourceforge.net>
	 <1065655452.13572.50.camel@torrey.et.myrio.com>
	 <yw1xad8bfg6q.fsf@users.sourceforge.net>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1065660704.848.10.camel@slurv>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 09 Oct 2003 02:51:44 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-09 at 01:44, Måns Rullgård wrote:
> When I tried it, I was running 2.6.0-test4.  The RAID5 was 4 120 GB
> Seagate disks on a Highpoint controller.

<snip>

> The other thing that I don't like, is the performance of the RAID
> array.  The disks individually give ~40 MB/s read speed, but the array
> only measures 25 MB/s.  I was of the impression, that RAID5 would give
> read speeds at least equal to the underlying disks.  Is this
> incorrect?

Was this a 4 port or 2 port HPT controller? Keep in mind, two disks on
the same IDE channel severely degrades performance, *especially* with
RAID.

-- 
Mvh,
André Tomt
andre@tomt.net

