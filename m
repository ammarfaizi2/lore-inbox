Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262858AbVDHPvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262858AbVDHPvd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 11:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbVDHPvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 11:51:32 -0400
Received: from smtp08.web.de ([217.72.192.226]:24974 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S262858AbVDHPvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 11:51:21 -0400
Subject: Re: [BUG] 2.6.12-rc1/rc2 mouse0 became mouse1
From: Ali Akcaagac <aliakc@web.de>
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d120d50005040807135bd29429@mail.gmail.com>
References: <1112961492.1618.3.camel@localhost>
	 <d120d50005040807135bd29429@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 17:51:45 +0200
Message-Id: <1112975505.1813.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-08 at 09:13 -0500, Dmitry Torokhov wrote:
> Input devices names are not guaranteed to be stable, they get them in
> order of their registration and therefore can change based on config,
> order in which modules are loaded and changes in other modules. In
> this case shift was caused by scroll support recently added to atkbd.
> 
> Ideally hotplug system should notify interested parties about current
> layout, but for programs that do not support dynamic setup changes
> please use mice multiplexor device (/dev/input/mice) that gives access
> to data from _all_ mouse-like devices in the system.
> 
> Hope that helps.

I see, thank you... Good to know this wasn't a bug or something.


