Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266028AbUF3Hzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266028AbUF3Hzd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 03:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUF3Hzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 03:55:33 -0400
Received: from vsat-148-63-57-162.c001.g4.mrt.starband.net ([148.63.57.162]:60127
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S266028AbUF3HyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 03:54:24 -0400
Message-ID: <40E27103.8040304@redhat.com>
Date: Wed, 30 Jun 2004 00:51:31 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a2) Gecko/20040627
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: inconsistency between SIOCGIFCONF and SIOCGIFNAME
References: <40E0EAC1.50101@redhat.com>	<20040629012604.20c3ad8b.davem@redhat.com>	<40E1BE7D.7070806@redhat.com>	<20040629141915.0268b741.davem@redhat.com>	<40E24573.5030403@redhat.com> <20040629221341.52824096.davem@redhat.com>
In-Reply-To: <20040629221341.52824096.davem@redhat.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

> This is especially unnecessary since rtnetlink does exactly what you
> want already, so we don't need to add a new interface nor change the
> semantics of an old one.

I do have code using netlink in cvs now.  We'll see whether people complain.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
