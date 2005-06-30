Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262844AbVF3S3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbVF3S3q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 14:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbVF3S3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 14:29:46 -0400
Received: from peabody.ximian.com ([130.57.169.10]:50887 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262844AbVF3S3o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 14:29:44 -0400
Subject: Re: Problem with inotify
From: Robert Love <rml@novell.com>
To: David =?ISO-8859-1?Q?G=F3mez?= <david@pleyades.net>
Cc: John McCutchan <ttb@tentacle.dhs.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050630181824.GA1058@fargo>
References: <20050630181824.GA1058@fargo>
Content-Type: text/plain; charset=utf-8
Date: Thu, 30 Jun 2005 14:29:48 -0400
Message-Id: <1120156188.6745.103.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-30 at 20:18 +0200, David Gómez wrote:

> I just patched 2.6.12 kernel with the inotify latest patch
> (inotify-0.23-rml-2.6.12-14.patch). Inotify is working ok with the test program
> provided in inotify-utils but... I can no longer mount my IDE cdrom devices
> :(. Each time i try to mount a disc, the mount proccess get stuck in D state. I
> don't see what's the relation between inotify and IDE devices, but if i switch
> back to the unpatched 2.6.12, mounting works again.

Very weird.

Did everything work with an earlier inotify?

Does wchan show anything useful (ps -ewo user,pid,command,wchan)?

Does it mount successfully once, and then subsequent mounts get suck, or
does even the first mount get stuck in D?

Thanks,

	Robert Love




