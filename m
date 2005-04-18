Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVDRBxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVDRBxv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 21:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVDRBxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 21:53:50 -0400
Received: from quechua.inka.de ([193.197.184.2]:48862 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261590AbVDRBxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 21:53:40 -0400
Date: Mon, 18 Apr 2005 03:53:28 +0200
From: Bernd Eckenfels <be-mail2005@lina.inka.de>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why Ext2/3 needs immutable attribute?
Message-ID: <20050418015328.GA1339@lina.inka.de>
References: <4ae3c140504170912b36e9b1@mail.gmail.com> <E1DNFkJ-0006SI-00@calista.eckenfels.6bone.ka-ip.net> <4ae3c140504171648d587669@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c140504171648d587669@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2005 at 07:48:50PM -0400, Xin Zhao wrote:
> any kernel level protection, including
> SELinux, could be disabled after the kernel is compromised. Am I
> missing some points here?

No, Immutable bit is an application of capabilities (or securelevel), you
are right.

If the kernel is compromised, the kernel is compromised. However immutable
bit can make it hard to circumvent kernel's protetion, even for root
attackers

Gruss
Bernd
