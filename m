Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVDIWMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVDIWMk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 18:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVDIWMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 18:12:40 -0400
Received: from isilmar.linta.de ([213.239.214.66]:9416 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261393AbVDIWMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 18:12:36 -0400
Date: Sun, 10 Apr 2005 00:12:35 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: lkml@Think-Future.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: CompactFlash mount Oops
Message-ID: <20050409221235.GA11167@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	lkml@Think-Future.de, linux-kernel@vger.kernel.org
References: <20050311104030.F182F44883@service.i-think-future.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050311104030.F182F44883@service.i-think-future.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The problem seems to be
> cs: pcmcia_socket0: voltage interrogation timed out.

Can you try passing the parameter

setup_delay=50

to the module named "pcmcia", please?

	Dominik
