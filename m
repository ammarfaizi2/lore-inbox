Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbTKQScU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 13:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTKQScU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 13:32:20 -0500
Received: from 64.221.211.208.ptr.us.xo.net ([64.221.211.208]:19344 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S263636AbTKQScT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 13:32:19 -0500
Subject: Re: Is initramfs freed after kernel is booted?
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3FB8ED43.2090102@pobox.com>
References: <E1ALlQs-000769-00.arvidjaar-mail-ru@f7.mail.ru>
	 <3FB8EBC2.1080800@nortelnetworks.com>  <3FB8ED43.2090102@pobox.com>
Content-Type: text/plain
Message-Id: <1069093938.18905.9.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 17 Nov 2003 10:32:18 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-17 at 07:46, Jeff Garzik wrote:

> You can't unmount rootfs.  And I'm not sure pivot_root will work, though 
> we're quickly reaching the end of my knowledge[1].  Certainly the 
> equivalent of "rm -rf *" will work.

The last time I checked (late 2.5.7x), pivot_root off an initramfs
didn't obviously break.  This isn't the same as working correctly, but
nothing clearly wrong happened either.

	<b

