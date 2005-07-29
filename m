Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262847AbVG2VNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262847AbVG2VNU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 17:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262841AbVG2VLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 17:11:02 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:39115 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262845AbVG2VK4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 17:10:56 -0400
X-ORBL: [63.202.173.158]
Date: Fri, 29 Jul 2005 14:10:50 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Syncing single filesystem (slow USB writing)
Message-ID: <20050729211050.GA24961@taniwha.stupidest.org>
References: <200507290731.32694.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507290731.32694.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2005 at 07:31:20AM +0400, Andrey Borzenkov wrote:

> Mandrake always mounted USB sticks with sync option; it was
> effectively noop except for a patch that implemented limited dsync
> semantic.

fwiw; various people have reported using flash block devices with
'sync' ruins them as there can be many more (and very frequent)
updates to the device

