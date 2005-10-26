Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbVJZGwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbVJZGwy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 02:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVJZGwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 02:52:54 -0400
Received: from duempel.org ([81.209.165.42]:1472 "HELO duempel.org")
	by vger.kernel.org with SMTP id S932555AbVJZGwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 02:52:54 -0400
Date: Wed, 26 Oct 2005 08:50:28 +0200
From: Max Kellermann <max@duempel.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1 and later: second ata_piix controller is invisible
Message-ID: <20051026065028.GA5678@roonstrasse.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20051025095646.GA24977@roonstrasse.net> <20051025103217.18d55c92.akpm@osdl.org> <20051025103310.51e1cdb2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051025103310.51e1cdb2.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005/10/25 19:33, Andrew Morton <akpm@osdl.org> wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > It'd be useful if you could test just 2.6.14-rc5+git-acpi.patch,
> >  see if that does the same thing.
> 
> And if that works OK, add git-libata-all.patch, retest.

results:

2.6.14-rc5 + git-acpi.patch + git-acpi-build-fix-2.patch:
ata2 and /dev/sdb are fine.

... + git-libata-all.patch
ata2 and /dev/sdb disappeared.

Tell me when you need further testing.

Max

