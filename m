Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWFGVMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWFGVMw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 17:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWFGVMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 17:12:52 -0400
Received: from hera.kernel.org ([140.211.167.34]:31204 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932409AbWFGVMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 17:12:52 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: klibc (was: 2.6.18 -mm merge plans)
Date: Wed, 7 Jun 2006 14:12:32 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e67fg0$grr$1@terminus.zytor.com>
References: <20060604135011.decdc7c9.akpm@osdl.org> <e65jj9$m9p$1@terminus.zytor.com> <200606071425.35802.ncunningham@linuxmail.org> <bda6d13a0606062351i5c94414fpa03ee2ce3dd180ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1149714752 17276 127.0.0.1 (7 Jun 2006 21:12:32 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 7 Jun 2006 21:12:32 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <bda6d13a0606062351i5c94414fpa03ee2ce3dd180ae@mail.gmail.com>
By author:    "Joshua Hudson" <joshudson@gmail.com>
In newsgroup: linux.dev.kernel
>
> Did anybody ever fix the can't pivot_root() the rootfs filesystem;
> hense can't use on a loopback system backed by NTFS?
> 

You shouldn't pivot_root the rootfs filesystem.  Use the run-init
utility or something similar instead (which does a mount with
MS_MOVE.)

	-hpa
