Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbVI0URE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbVI0URE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 16:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbVI0URE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 16:17:04 -0400
Received: from [81.2.110.250] ([81.2.110.250]:55006 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751031AbVI0URC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 16:17:02 -0400
Subject: Re: 2.6.13.2: USB wedged
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Olaf Titz <olaf@bigred.inka.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1EKJyP-0001lb-00@bigred.inka.de>
References: <E1EKJyP-0001lb-00@bigred.inka.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Sep 2005 21:44:07 +0100
Message-Id: <1127853847.10674.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-09-27 at 20:14 +0200, Olaf Titz wrote:
> Sometimes when trying to print big jobs on an HP LJ 1022 it happens
> that all processes accessing USB get stuck in D state.
> I captured the following relevant stack traces, but apparently this does not
> include kernel threads (there was another "khubd" stuck):

I've had a couple of almost identical traces here. In my case I also
have a hub which comes and goes as it is part of the monitor and when
the monitor goes into deep sleep it turns off [*].

Alan

[*] and yes if you plug your keyboard and mouse into the hub you realise
the designer wasn't thinking.

