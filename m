Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265025AbTFMABE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 20:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265069AbTFMABD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 20:01:03 -0400
Received: from rth.ninka.net ([216.101.162.244]:53123 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S265025AbTFMABC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 20:01:02 -0400
Subject: Re: Logical bug in ipv4 (and ipv6?) PMTU handling?
From: "David S. Miller" <davem@redhat.com>
To: Harald =?ISO-8859-1?Q?Nordg=E5rd-Hansen?= <hnh@linpro.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <xon1xxzys2k.fsf@ruth.frs.linpro.no>
References: <xon1xxzys2k.fsf@ruth.frs.linpro.no>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1055463280.28700.0.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 Jun 2003 17:14:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-12 at 13:11, Harald Nordgård-Hansen wrote:
> I was helping a collegue here trying to get some udp packets through a
> link, and stumbled upon what seems to be a bug in the ipv4 code of
> current kernels (checked 2.4.20, 2.4.21-pre8 and 2.5.70).

It's not a bug, we do UDP path mtu discovery on purpose.

-- 
David S. Miller <davem@redhat.com>
