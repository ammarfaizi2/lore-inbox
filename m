Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbWJBAbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbWJBAbl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 20:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWJBAbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 20:31:41 -0400
Received: from isilmar.linta.de ([213.239.214.66]:57538 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932530AbWJBAbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 20:31:40 -0400
Date: Mon, 2 Oct 2006 02:31:38 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-pcmcia@lists.infradead.org, fabrice@bellet.info,
       linux-kernel@vger.kernel.org
Subject: Re: pcmcia: patch to fix pccard_store_cis
Message-ID: <20061002003138.GB16938@isilmar.linta.de>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>,
	linux-pcmcia@lists.infradead.org, fabrice@bellet.info,
	linux-kernel@vger.kernel.org
References: <20061001122107.9260aa5d.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061001122107.9260aa5d.zaitcev@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Oct 01, 2006 at 12:21:07PM -0700, Pete Zaitcev wrote:
> The ``ret'' obviously cannot be zero here, because it's initialized to the
> write count and not zero.

Thanks -- Linus was faster, though, and already applied his patch to the
linux-2.6 git tree. Regarding the other issue seen in RH bug# 207910, I'll
try to take a look at it soon.

	Dominik
