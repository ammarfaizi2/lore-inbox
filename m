Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbUCGVdV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 16:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbUCGVdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 16:33:21 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:44983
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262339AbUCGVdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 16:33:20 -0500
Message-ID: <404B950B.8010205@redhat.com>
Date: Sun, 07 Mar 2004 13:32:59 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040307
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mike@theoretic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Potential bug in fs/binfmt_elf.c?
References: <1078508281.3065.33.camel@linux.littlegreen> <404A1C71.3010507@redhat.com> <1078607410.10313.7.camel@linux.littlegreen> <404ABD06.4060607@redhat.com> <pan.2004.03.07.09.58.43.675972@codeweavers.com> <404AFD72.3070306@redhat.com> <pan.2004.03.07.11.53.54.970527@codeweavers.com>
In-Reply-To: <pan.2004.03.07.11.53.54.970527@codeweavers.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Hearn wrote:

> But can it handle this case, or will it also map the load area ELF section
> wrongly?

It will most probably do something you don't want.

But ld.so is no particularly special program.  Just write your own very
small and specialized dynamic loader which does exactly what you need.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
