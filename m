Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbTDDUKy (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 15:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbTDDUKy (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 15:10:54 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:25991 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261378AbTDDUKy (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 15:10:54 -0500
Date: Fri, 4 Apr 2003 21:22:12 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.66-ac2
Message-ID: <20030404202204.GF29047@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <200304041959.h34JxXE25668@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304041959.h34JxXE25668@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 02:59:33PM -0500, Alan Cox wrote:

 > o	Fix taint mishandling for AMD CPU		(Manfred Spraul)

>From a quick look at the patch, this seems to add a per-cpu check,
but uses cpu_has_mp(), which only checks the boot CPU on each iteration.

		Dave

