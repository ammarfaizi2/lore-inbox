Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267739AbUG3QpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267739AbUG3QpA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 12:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267738AbUG3Qo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 12:44:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11654 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267739AbUG3Qo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 12:44:57 -0400
Message-ID: <410A7A86.6030206@redhat.com>
Date: Fri, 30 Jul 2004 09:42:46 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040728
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: symlinks follow 8 or 5?
References: <1091079278.1999.5.camel@localhost.localdomain>	 <slrn-0.9.7.4-22364-14114-200407301259-tc@hexane.ssi.swin.edu.au> <1091171770.2794.4.camel@laptop.fenrus.com>
In-Reply-To: <1091171770.2794.4.camel@laptop.fenrus.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> you haven't been paying attention.... the current 2.6 kernels have a
> patch series that is fixing this for most filesystems already 

Which reminds me: how can we safely determine whether this is
implemented for a local filesystem from userland?  Unless we can do I
cannot change the value of SYMLOOP_MAX and people will not be able to
take advantage of the raised limit safely.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
