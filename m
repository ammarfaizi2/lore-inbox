Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132610AbQLQO7u>; Sun, 17 Dec 2000 09:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132666AbQLQO7k>; Sun, 17 Dec 2000 09:59:40 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:46755 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S132610AbQLQO72>; Sun, 17 Dec 2000 09:59:28 -0500
Date: Sun, 17 Dec 2000 14:29:01 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Jani Monoses <jani@virtualro.ic.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] docbook fix kmod.c
Message-ID: <20001217142901.B22587@redhat.com>
In-Reply-To: <Pine.LNX.4.10.10012161725040.11062-100000@virtualro.ic.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012161725040.11062-100000@virtualro.ic.ro>; from jani@virtualro.ic.ro on Sat, Dec 16, 2000 at 05:26:09PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2000 at 05:26:09PM +0200, Jani Monoses wrote:

> 	kernel-api.tmpl references the exported functions of kmod.c but
> there are none.

There are: hotplug_path, exec_usermodehelper, call_usermodehelper,
request_module.

Try adding kmod.c to APISOURCES in the Makefile.

Tim.
*/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
