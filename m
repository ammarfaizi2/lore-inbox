Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273244AbTG3SoN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 14:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273245AbTG3SoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 14:44:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:17044 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S273244AbTG3SoM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 14:44:12 -0400
Date: Wed, 30 Jul 2003 11:44:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stefano Rivoir <s.rivoir@gts.it>
Cc: lista1@telia.com, linux-kernel@vger.kernel.org
Subject: Re: Disk performance degradation
Message-Id: <20030730114428.7e629895.akpm@osdl.org>
In-Reply-To: <3F27ECFA.5020005@gts.it>
References: <20030729182138.76ff2d96.lista1@telia.com>
	<3F2786E9.9010808@gts.it>
	<20030730035524.65cfc39a.akpm@osdl.org>
	<3F27ECFA.5020005@gts.it>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefano Rivoir <s.rivoir@gts.it> wrote:
>
> I think I've got it. 2.4 fails to load DRI, so when X is up there is
>  memory available until the load of gnucash, the last operation. 2.6
>  loads dri and probably this eats too much too early, causing the
>  system to touch swap since the first operation after X startup.

hrm, Why should loading DRI in X consume a significant amount of memory?

How much more memory is X using when DRI is loaded?
