Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263901AbUDPWTb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263887AbUDPWTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:19:19 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:24536
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263901AbUDPWR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 18:17:58 -0400
Message-ID: <40805B80.30105@redhat.com>
Date: Fri, 16 Apr 2004 15:17:36 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Riesen <fork0@users.sourceforge.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: POSIX message queues, libmqueue: mq_open, mq_unlink
References: <20040416213851.GA1784@steel.home>
In-Reply-To: <20040416213851.GA1784@steel.home>
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen wrote:

> And if the kernel code does check the incoming arguments correctly,
> what is the point to check them again? Just to make the point, that
> passing in not an absolute path is not portable?

Forget what the kernel does.  This is enforcement of the API the runtime
provides.  If must be stable regardless of what the kernel does.
Including kernel changes which allow special names which do funky,
non-standard things.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
