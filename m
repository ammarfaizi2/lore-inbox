Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbUBKFYn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 00:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUBKFYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 00:24:43 -0500
Received: from gate.crashing.org ([63.228.1.57]:43410 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263424AbUBKFYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 00:24:42 -0500
Subject: Re: Fwd: [Swsusp-devel] Kernel 2.6 pm_send_all() issues.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Frank <mhf@linuxmail.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Wolfgang Glas <wolfgang.glas@ev-i.at>,
       swsusp-devel@lists.sourceforge.net
In-Reply-To: <200402102343.06896.mhf@linuxmail.org>
References: <200402102343.06896.mhf@linuxmail.org>
Content-Type: text/plain
Message-Id: <1076476981.866.82.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 11 Feb 2004 16:23:02 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-11 at 02:43, Michael Frank wrote:
> This question is probably better suited for LKML.

Get nVidia to fix their drivers. pm_send_all() stuff is deprecated
and isn't called on purpose. Some of the handlers for these old-style
calls were doing weird stuff I'd rather not do again ;)

Ben.


