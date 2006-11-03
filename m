Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753525AbWKCUlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525AbWKCUlF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753526AbWKCUlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:41:05 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39373 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1753525AbWKCUlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:41:03 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: olson@pathscale.com, <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH 0/2] htirq: generalization
References: <454A7B0F.7060701@pathscale.com>
	<m1odrpymqc.fsf@ebiederm.dsl.xmission.com>
	<454B7B70.9060104@pathscale.com>
	<m1d584xutk.fsf@ebiederm.dsl.xmission.com>
	<454B880A.1010802@pathscale.com>
	<m1zmb8wexd.fsf@ebiederm.dsl.xmission.com>
	<454B8E19.90300@pathscale.com>
Date: Fri, 03 Nov 2006 13:40:42 -0700
In-Reply-To: <454B8E19.90300@pathscale.com> (Bryan O'Sullivan's message of
	"Fri, 03 Nov 2006 10:44:41 -0800")
Message-ID: <m1irhww9f9.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok.  I think this is what we need to do to generalize the
htirq code so that we can use it on hardware that doesn't
connect the standard configuration registers to control
of the htirq.

Bryan please take a look and see if you can use these to
fix the ipath hypertransport card driver.

Eric
