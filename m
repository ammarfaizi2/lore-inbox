Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbUFCHpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUFCHpo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 03:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbUFCHpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 03:45:44 -0400
Received: from mail1.kontent.de ([81.88.34.36]:25216 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261648AbUFCHpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 03:45:43 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [RFC] Changing SysRq - show registers handling
Date: Thu, 3 Jun 2004 09:44:01 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       greg@kroah.com, vojtech@suse.cz
References: <200406030134.04121.dtor_core@ameritech.net> <20040603001804.750b7fa5.akpm@osdl.org> <200406030227.22178.dtor_core@ameritech.net>
In-Reply-To: <200406030227.22178.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200406030944.01615.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 3. Juni 2004 09:27 schrieb Dmitry Torokhov:
> I don't like the requirement of SysRq request processing being in hard
> interrupt handler - that excludes uinput-generated events and precludes
> moving keyboard handling to a tasklet for example.

SysRq should work even if bottom halfs don't.

	Regards
		Oliver

