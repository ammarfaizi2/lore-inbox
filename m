Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbUCGLtC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 06:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbUCGLtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 06:49:02 -0500
Received: from main.gmane.org ([80.91.224.249]:32702 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261817AbUCGLtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 06:49:00 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Mike Hearn <mh@codeweavers.com>
Subject: Re: Potential bug in fs/binfmt_elf.c?
Date: Sun, 07 Mar 2004 11:53:55 +0000
Organization: CodeWeavers, Inc
Message-ID: <pan.2004.03.07.11.53.54.970527@codeweavers.com>
References: <1078508281.3065.33.camel@linux.littlegreen> <404A1C71.3010507@redhat.com> <1078607410.10313.7.camel@linux.littlegreen> <404ABD06.4060607@redhat.com> <pan.2004.03.07.09.58.43.675972@codeweavers.com> <404AFD72.3070306@redhat.com>
Reply-To: mike@theoretic.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: e-ucs036.dur.ac.uk
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Mar 2004 02:46:10 -0800, Ulrich Drepper wrote:
> No.  It only handles what is necessary.

But can it handle this case, or will it also map the load area ELF section
wrongly?

