Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263235AbTKETvm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 14:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTKETvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 14:51:09 -0500
Received: from pizda.ninka.net ([216.101.162.242]:19866 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263170AbTKETuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 14:50:39 -0500
Date: Wed, 5 Nov 2003 11:43:32 -0800
From: "David S. Miller" <davem@redhat.com>
To: jt@hpl.hp.com
Cc: jt@bougret.hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6 IrDA] IrLMP open leak
Message-Id: <20031105114332.4c701bca.davem@redhat.com>
In-Reply-To: <20031105194125.GD24323@bougret.hpl.hp.com>
References: <20031105194125.GD24323@bougret.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Nov 2003 11:41:25 -0800
Jean Tourrilhes <jt@bougret.hpl.hp.com> wrote:

> ir2609_irlmp_open_leak.diff :
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 		<Original patch from Chris Wright>
> 	o [CORRECT] Prevent 'self' leak on error in irlmp_open.
> 		ASSERT is compiled in only with DEBUG option => risk = 0.

Applied, thanks.
