Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWGLT6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWGLT6c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 15:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWGLT6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 15:58:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12680 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932133AbWGLT6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 15:58:31 -0400
Subject: Re: [PATCH] sysctl: Allow /proc/sys without sys_sysctl
From: Arjan van de Ven <arjan@infradead.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060712112432.0cd5996f@dxpl.pdx.osdl.net>
References: <m1u05pkruk.fsf@ebiederm.dsl.xmission.com>
	 <200607121652.21920.ak@suse.de> <m1lkqyc00d.fsf@ebiederm.dsl.xmission.com>
	 <200607121808.26555.ak@suse.de> <m1ac7ebx0v.fsf@ebiederm.dsl.xmission.com>
	 <20060712112432.0cd5996f@dxpl.pdx.osdl.net>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 21:58:29 +0200
Message-Id: <1152734309.3217.71.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-12 at 11:24 -0700, Stephen Hemminger wrote:
> What is the motivation behind killing the sys_sysctl call anyway?
> Sure its more ugly esthetically but it works.

it "works" but the thing is that the number space is NOT stable, and as
such it's a really bad ABI

