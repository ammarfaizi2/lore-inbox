Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265644AbTF2M2E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 08:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265645AbTF2M2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 08:28:04 -0400
Received: from [66.212.224.118] ([66.212.224.118]:36870 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S265644AbTF2M2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 08:28:02 -0400
Date: Sun, 29 Jun 2003 08:30:34 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Oops in __change_page_attr Re: (was 2.5.73-mm2)
In-Reply-To: <Pine.LNX.4.53.0306290806230.1878@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.53.0306290830080.1878@montezuma.mastecende.com>
References: <Pine.LNX.4.53.0306290806230.1878@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jun 2003, Zwane Mwaikambo wrote:

> On Sat, 28 Jun 2003, William Lee Irwin III wrote:
> 
> > On Sat, Jun 28, 2003 at 04:00:13PM -0700, Andrew Morton wrote:
> > > What architectures has this been tested on?
> > 
> > i386 only, CONFIG_HIGHMEM64G with various combinations of highpte &
> > highpmd, and nohighmem. No CONFIG_HIGHMEM4G or non-i386 machines that
> > can run 2.5.x are within my grasp (obviously CONFIG_HIGHMEM4G machines
> > could, I just don't have them, and the discontig code barfs on mem=).
> 
> Well i just tried it on a 16G box with CONFIG_HIGHMEM4G;
> 
> Manfred, Bill said this would be best routed your way.

Just to isolate things, this still occurs without highpmd.

-- 
function.linuxpower.ca
