Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262969AbUCXCOK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 21:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbUCXCOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 21:14:10 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:57528
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262969AbUCXCOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 21:14:08 -0500
Message-ID: <4060EBEA.7080807@redhat.com>
Date: Tue, 23 Mar 2004 18:01:14 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Non-Exec stack patches
References: <20040323231256.GP4677@tpkurt.garloff.de>	<20040323154937.1f0dc500.akpm@osdl.org>	<20040324002149.GT4677@tpkurt.garloff.de>	<16480.55450.730214.175997@napali.hpl.hp.com>	<4060E24C.9000507@redhat.com> <16480.59229.808025.231875@napali.hpl.hp.com>
In-Reply-To: <16480.59229.808025.231875@napali.hpl.hp.com>
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:

> What stack protections other than RW- and RWX are useful?

It's not about "what protections".  The three currently recognized
states are PT_GNU_STACK not present, rwx, rw-.  Ingo's code documents
this.  For those who need more, I'll have a paper coming up for a
conference in Toronto in April.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
