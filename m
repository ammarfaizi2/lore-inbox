Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751732AbWB0TIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbWB0TIY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbWB0TIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:08:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:25318 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751710AbWB0TIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:08:23 -0500
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
From: Arjan van de Ven <arjan@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       gregkh@suse.de, Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20060227190150.GA9121@kroah.com>
References: <20060227190150.GA9121@kroah.com>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 20:08:18 +0100
Message-Id: <1141067298.2992.154.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 11:01 -0800, Greg KH wrote:
> Hi all,
> 
> As has been noticed recently by a lot of different people, it seems like
> we are breaking the userspace<->kernelspace interface a lot.  Well, in
> looking back over time, we always have been doing this, but no one seems
> to notice (proc files changing format and location, netlink library
> bindings, etc.)


2 remarks

1) it would make sense to keep track of "removed" interfaces as well

2) the per interface description needs a "depends on config option"
field; not all options are always there, but depend on a config option
to be set. It makes a lot of sense to mark these as such so that users
KNOW they have to deal with the interface not being there occasionally,
depending on the kernel.



