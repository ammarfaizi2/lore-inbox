Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbUKWTwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbUKWTwj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 14:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbUKWTuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:50:15 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:38688 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261504AbUKWTr1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 14:47:27 -0500
Date: Tue, 23 Nov 2004 20:47:45 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Joakim Bentholm XQ (AS/EAB)" <joakim.xq.bentholm@ericsson.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Compatibility problem with C++, i386 & ia64 platform
Message-ID: <20041123194745.GB8367@mars.ravnborg.org>
Mail-Followup-To: "Joakim Bentholm XQ (AS/EAB)" <joakim.xq.bentholm@ericsson.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <D6A41B94D27EA643BAE9319F5348603F17D6B3@ESEALNT895.al.sw.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D6A41B94D27EA643BAE9319F5348603F17D6B3@ESEALNT895.al.sw.ericsson.se>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Snipped - about C++ compatibility]

The Linux kernel philosofy is not to support any type of C++.
And kernel provided header files are not supposed to be included
from userspace - use a sanitized version instead.

Developing modules in C++ is not supported.

	Sam
