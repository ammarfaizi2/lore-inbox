Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271235AbTGWT2z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 15:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271237AbTGWT1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 15:27:54 -0400
Received: from quechua.inka.de ([193.197.184.2]:13217 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S271235AbTGWT0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 15:26:23 -0400
Subject: Re: kernel bug in socketpair()
From: Andreas Jellinghaus <aj@dungeon.inka.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030723100043.18d5b025.davem@redhat.com>
References: <200307231428.KAA15254@raptor.research.att.com>
	 <20030723074615.25eea776.davem@redhat.com>
	 <200307231656.MAA69129@raptor.research.att.com>
	 <20030723100043.18d5b025.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1058989300.12715.62.camel@simulacron>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 23 Jul 2003 21:41:40 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mit, 2003-07-23 at 19:00, David S. Miller wrote:
> If we're talking about the current process, there is no use in using
> /proc/*/fd/N to open a file descriptor in the first place, you can
> simply call open(N,...)

maybe you can use open on /proc/fd/*/N to open a file
already deleted from the filesystem? That might be useful.

Andreas

