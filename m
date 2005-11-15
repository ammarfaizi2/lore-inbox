Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbVKOPHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbVKOPHH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 10:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbVKOPHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 10:07:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10129 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932385AbVKOPHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 10:07:05 -0500
Date: Tue, 15 Nov 2005 10:06:43 -0500
From: Dave Jones <davej@redhat.com>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] I2O: Bugfixes
Message-ID: <20051115150643.GB4516@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Markus Lidel <Markus.Lidel@shadowconnect.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <4379AAED.3020307@shadowconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4379AAED.3020307@shadowconnect.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 10:31:25AM +0100, Markus Lidel wrote:
 > Changes:
 > --------
 > - Removed some kmalloc's with __GFP_ZERO and replace it with memset()
 >   because it didn't work properly.

kzalloc() perhaps ?

		Dave

