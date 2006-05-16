Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751843AbWEPQG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbWEPQG4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751841AbWEPQG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:06:56 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:12243
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751843AbWEPQGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:06:55 -0400
Message-Id: <446A14F3.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Tue, 16 May 2006 18:07:47 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: [PATCH 3/3] reliable stack trace support (i386)
References: <4469FC41.76E4.0078.0@novell.com> <200605161715.11405.ak@suse.de>
In-Reply-To: <200605161715.11405.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> +static asmlinkage void show_trace_unwind(struct unwind_frame_info *info, void *log_lvl)
>
>static asmlinkage ?

Yes, as it's being used as a callback from assembly.

Jan
