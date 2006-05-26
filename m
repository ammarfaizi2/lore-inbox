Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWEZAYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWEZAYV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 20:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWEZAYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 20:24:20 -0400
Received: from agrajag.inprovide.com ([82.153.166.94]:33678 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S932182AbWEZAYU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 20:24:20 -0400
To: Diego Calleja <diegocg@gmail.com>
Cc: dev@opensound.com, linux-kernel@vger.kernel.org
Subject: Re: How to check if kernel sources are installed on a system?
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe>
	<20060526010041.6f9ecde7.diegocg@gmail.com>
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Fri, 26 May 2006 01:24:18 +0100
In-Reply-To: <20060526010041.6f9ecde7.diegocg@gmail.com> (Diego Calleja's message of "Fri, 26 May 2006 01:00:41 +0200")
Message-ID: <yw1x4pzdws3x.fsf@agrajag.inprovide.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja <diegocg@gmail.com> writes:

> El Thu, 25 May 2006 18:29:22 -0400,
> Lee Revell <rlrevell@joe-job.com> escribió:
>
>> I'd really like to see a distro-agnostic way to retrieve the kernel
>> configuration.  /proc/config.gz has existed for soem time but many
>> distros inexplicably don't enable it.
>
> /proc/config.gz takes a bit of memory, and wasting such memory when

Yes, 9k on my machine.

> you can store the config at /boot/config-`uname -r` is a bit weird.

There's no guaranteeing that file will match the running kernel.  Then
again, modules can be changed without /proc/config.gz changing.

-- 
Måns Rullgård
mru@inprovide.com
