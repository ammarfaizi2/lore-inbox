Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266167AbUF3GsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266167AbUF3GsR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 02:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266155AbUF3GsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 02:48:16 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:35676 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266167AbUF3GsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 02:48:09 -0400
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: s390(64) per_cpu in modules (ipv6)
X-Message-Flag: Warning: May contain useful information
References: <20040629233537.523db68c@lembas.zaitcev.lan>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 29 Jun 2004 23:46:08 -0700
In-Reply-To: <20040629233537.523db68c@lembas.zaitcev.lan> (Pete Zaitcev's
 message of "Tue, 29 Jun 2004 23:35:37 -0700")
Message-ID: <528ye5lf0v.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 30 Jun 2004 06:46:08.0376 (UTC) FILETIME=[EC65D780:01C45E6D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Pete> It seems to work fine, but I'm wondering if a better fix can
    Pete> be found.  Ideas?

Not sure if it will work (and I don't have an s390 toolchain handy!)
but this (static variable used only by asm) seems to be exactly the
situation that __attribute_used__ is intended for.

 - Roland

