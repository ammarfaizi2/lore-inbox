Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbTJRPsZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 11:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbTJRPsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 11:48:25 -0400
Received: from main.gmane.org ([80.91.224.249]:22436 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261640AbTJRPsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 11:48:24 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: orinoco_cs module broken in test8
Date: Sat, 18 Oct 2003 17:48:21 +0200
Message-ID: <yw1xoeweim2i.fsf@users.sourceforge.net>
References: <200310181723.54967.aviram@beyondsecurity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:P1kxq+Bd36WXDUIPIumtoYDKmKM=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aviram Jenik <aviram@beyondsecurity.com> writes:

> Orinoco_cs worked for me in all previous 2.6.0-testx versions, but stopped 
> working in test8. Message log shows:
> kernel: orinoco_cs: RequestIRQ: Unsupported mode

You have to enable ISA bus support, i.e. CONFIG_ISA=y.

-- 
Måns Rullgård
mru@users.sf.net

