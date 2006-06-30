Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbWF3RRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbWF3RRa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 13:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbWF3RRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 13:17:30 -0400
Received: from mailhost.alabanza.com ([209.239.39.56]:8079 "EHLO
	mailhost.alabanza.com") by vger.kernel.org with ESMTP
	id S932537AbWF3RR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 13:17:29 -0400
From: eclark <eclark@alabanza.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: problem with new kernel
Date: Fri, 30 Jun 2006 13:13:13 -0400
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200606301046.17526.eclark@alabanza.com> <1151685938.11434.51.camel@laptopd505.fenrus.org>
In-Reply-To: <1151685938.11434.51.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="euc-kr"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606301313.13691.eclark@alabanza.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies for the double email. For what its worth:

[root@dev linux-2.4.32]# getconf GNU_LIBPTHREAD_VERSION
NPTL 0.60

Not sure what that implies (other than its still broke. :| )

On Friday 30 June 2006 12:45 pm, Arjan van de Ven wrote:
> Hi,
>
> you're running a kernel without NPTL support on a distribution that
> apparently expects NPTL support to be in the kernel... the failure mode
> isn't nice but failure at all isn't totally unexpected...... NPTL is
> needed for certain functionality and if a distribution expects that to
> be there.. things may well go very wonky if absent. (yes glibc tries to
> emulate this but the emulation is quite limited and not really possible)
