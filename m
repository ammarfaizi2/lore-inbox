Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266772AbUFRTsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266772AbUFRTsa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 15:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266596AbUFRTpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 15:45:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:17798 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266613AbUFRTlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 15:41:11 -0400
Date: Fri, 18 Jun 2004 12:43:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz, vojtech@ucw.cz
Subject: Re: [PATCH 8/11] serio sysfs integration
Message-Id: <20040618124351.76872a71.akpm@osdl.org>
In-Reply-To: <200406180750.26570.dtor_core@ameritech.net>
References: <200406180335.52843.dtor_core@ameritech.net>
	<200406180342.11056.dtor_core@ameritech.net>
	<20040618023853.5d4ee96a.akpm@osdl.org>
	<200406180750.26570.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
> description 	- i8042 Aux Port
> driver		- psmouse
> legacy_position	- isa0060/serio1 (take from serio's phys, can be used
> to match with /proc/bus/input/devices).
> 
> Every driver will have a set of custom attributes that will be documented
> on one by one basis. Btw, where would you document it? Documentation
> directory entry? Something else?

Conceivably one could attempt to document it via module_parm_desc in each
driver, but I presume that won't work for a host of reasons.

So yup, a succinct description in Documentation/input/ would be great.
