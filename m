Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269016AbTGJHi4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 03:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269017AbTGJHi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 03:38:56 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:24077 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269016AbTGJHiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 03:38:54 -0400
Date: Thu, 10 Jul 2003 08:53:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: RFC:  what's in a stable series?
Message-ID: <20030710085332.B28672@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <3F0CBC08.1060201@pobox.com> <20030710033409.GA1498@www.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030710033409.GA1498@www.13thfloor.at>; from herbert@13thfloor.at on Thu, Jul 10, 2003 at 05:34:09AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 05:34:09AM +0200, Herbert Pötzl wrote:
> In my opinion (and you requested input *g*), the
> kernel userland API can be changed as much as is
> required to improve/stabilize/bugfix the kernel,
> unless this change breaks something in userland
> without an already available update/upgrade/etc ...

Changing the kernel/userland API and ABI is totally out of question - 
we _really_ can't do that.  This is about inkernel APIs for modules.
