Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbTEWIPD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 04:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263928AbTEWIPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 04:15:03 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:3780 "EHLO gaston")
	by vger.kernel.org with ESMTP id S263922AbTEWIPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 04:15:03 -0400
Subject: Re: Linux 2.4.21-rc3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55L.0305221915450.1975@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0305221915450.1975@freak.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053678472.1160.90.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 May 2003 10:27:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   o add a hold field to reserve ide slots (needed for PPC)

Ah good, you merged this one. I'm sending you separately a patch
that makes use of this field in the pmac driver to fix the problem
we had with ide-cs (among others)

Ben.

