Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264529AbUEJIS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264529AbUEJIS2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 04:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbUEJIS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 04:18:28 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:31428 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264529AbUEJIS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 04:18:27 -0400
Date: Mon, 10 May 2004 01:17:02 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>,
       Niccolo Rigacci <niccolo@rigacci.org>, linux-kernel@vger.kernel.org
Subject: Re: 2Gb file size limit on 2.4.24, LVM and ext3?
Message-ID: <20040510081702.GA10157@taniwha.stupidest.org>
References: <20040506172152.GB17351@paros.rigacci.org> <409AA9EA.9020108@pointblue.com.pl> <20040507100142.GA30872@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040507100142.GA30872@harddisk-recovery.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2004 at 12:01:42PM +0200, Erik Mouw wrote:

> I always forget about the glibc #define-du-jour to get O_LARGEFILE
> defined, this always works.

#define _GNU_SOURCE
#include <...>

