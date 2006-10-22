Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423118AbWJVGt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423118AbWJVGt2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 02:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423108AbWJVGt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 02:49:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29126 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423118AbWJVGt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 02:49:27 -0400
Date: Sat, 21 Oct 2006 23:49:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Linux Portal" <linportal@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: First benchmarks of the ext4 file system
Message-Id: <20061021234923.defbfb1f.akpm@osdl.org>
In-Reply-To: <ceccffee0610211657u66b758b7r78fbf1c75f5dea67@mail.gmail.com>
References: <ceccffee0610211657u66b758b7r78fbf1c75f5dea67@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Oct 2006 01:57:36 +0200
"Linux Portal" <linportal@gmail.com> wrote:

> ext4 is 20 percent faster writer than ext3 or reiser4, probably thanks
> to extents and delayed allocation. On other tests it is either
> slightly faster or slightly slower. reiser4 comes as a nice surprise,
> winning few benchmarks. Both are very stable, no errors during
> testing.
> 
> http://linux.inet.hr/first_benchmarks_of_the_ext4_file_system.html

ext4 doesn't implement delayed allocation (yet).

I made some observations regarding comparative benchmarking of filesystems
when releasing 2.6.19-rc1-mm1.  They seem to have been ignored ;)  See

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/announce.txt

