Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbVIIMww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbVIIMww (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 08:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbVIIMww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 08:52:52 -0400
Received: from cantor.suse.de ([195.135.220.2]:60353 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751445AbVIIMww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 08:52:52 -0400
From: Andi Kleen <ak@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH 2.6.13] x86_64: Add notify_die() to another spot in do_page_fault()
Date: Fri, 9 Sep 2005 14:52:29 +0200
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050908163840.GR3966@smtp.west.cox.net> <200509091001.01325.ak@suse.de> <20050909124711.GA3041@smtp.west.cox.net>
In-Reply-To: <20050909124711.GA3041@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509091452.30032.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 September 2005 14:47, Tom Rini wrote:

> "no context" is passed to the functions as well, and in KGDB we strcmp
> on that.

Please define a new DIE code instead.

-Andi



