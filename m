Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030418AbWJYSZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030418AbWJYSZX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 14:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030467AbWJYSZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 14:25:23 -0400
Received: from main.gmane.org ([80.91.229.2]:50898 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030418AbWJYSZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 14:25:21 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: Link lib to a kernel module
Date: Wed, 25 Oct 2006 18:24:29 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnejvbbc.93p.olecom@flower.upol.cz>
References: <20061024105518.GA55219@server.idefix.loc> <slrnejs14h.93p.olecom@flower.upol.cz> <20061025122609.GA86838@server.idefix.loc>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: Oleg Verych <olecom@flower.upol.cz>, kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
User-Agent: slrn/0.9.8.1pl1 (Debian)
Cc: kbuild-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-10-25, Matthias Fechner wrote:
[]
> Makefile:
> KDIR    := /lib/modules/$(shell uname -r)/build
> PWD := $(shell pwd)

there's $(CURDIR), just in case...
____

