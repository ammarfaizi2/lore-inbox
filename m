Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262641AbVGOBVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbVGOBVQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 21:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbVGOBVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 21:21:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8414 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262641AbVGOBVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 21:21:09 -0400
Date: Thu, 14 Jul 2005 18:21:01 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Thoralf Will <thoralf@cipsoft.com>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com, bmaly@redhat.com
Subject: Re: pc_keyb: controller jammed (0xA7)
Message-Id: <20050714182101.640137d8.zaitcev@redhat.com>
In-Reply-To: <mailman.1121358841.8002.linux-kernel2news@redhat.com>
References: <mailman.1121358841.8002.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0beta3 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2005 18:27:01 +0200, Thoralf Will <thoralf@cipsoft.com> wrote:

> I didn't find any useful answer anywhere so far, hope it's ok to ask here.
> I'm currently trying to get a 2.4.31 up and running on an IBM
> BladeCenter HS20/8843. (base system is a stripped down RH9)
> 
> When booting the kernel the console is spammmed with:
>    pc_keyb: controller jammed (0xA7)
> But it seems there are no further consequences and the keyboard is
> working.

I saw a patch for it by Brian Maly, and yes, it was for 2.4.x.
Maybe he can send you a rediff against current Marcelo's tree.

However, is there a reason you're running 2.4.31 in Summer of 2005?
Did you try 2.6, does that one do the same thing? It has a rather
different infrastructure with the serio.

-- Pete
