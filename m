Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVA1LQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVA1LQE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 06:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVA1LQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 06:16:03 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:50407 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261274AbVA1LQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 06:16:02 -0500
Date: Fri, 28 Jan 2005 12:15:57 +0100
From: Michael Gernoth <simigern@stud.uni-erlangen.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AT-Keyboard probing too strict in current bk?
Message-ID: <20050128111557.GA14265@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org
References: <20050127164734.GA12899@cip.informatik.uni-erlangen.de> <200501272259.21091.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501272259.21091.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 10:59:20PM -0500, Dmitry Torokhov wrote:
> Thanks for noticing this. The following patch should fix timeout
> handling in libps2 and restore previous behavior:

This fixes it for me. I tested it with an unmodified atkbd.c and
the old firmware for my keyboard converter.

Thanks,
  Michael
