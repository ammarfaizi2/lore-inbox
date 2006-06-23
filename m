Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbWFWMtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbWFWMtU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 08:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbWFWMtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 08:49:20 -0400
Received: from cantor.suse.de ([195.135.220.2]:53156 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932565AbWFWMtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 08:49:19 -0400
To: Olivier Galibert <galibert@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is the x86-64 kernel size limit real?
References: <20060622204627.GA47994@dspnet.fr.eu.org>
From: Andi Kleen <ak@suse.de>
Date: 23 Jun 2006 14:49:13 +0200
In-Reply-To: <20060622204627.GA47994@dspnet.fr.eu.org>
Message-ID: <p73hd2cnik6.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert <galibert@pobox.com> writes:

> I get bitched at by the build process because the kernel I get is
> around 4.5Mb compressed.  i386 does not have that limitation.
> Interestingly, a diff between the two build.c gives:

A patch to fix it is already queued for 2.6.18

Also long term it might be completely dropped when the uncompressor
moves to long mode.

-Andi
