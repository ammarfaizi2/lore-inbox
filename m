Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269535AbUICBcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269535AbUICBcA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 21:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269475AbUICB25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 21:28:57 -0400
Received: from trantor.org.uk ([213.146.130.142]:62611 "EHLO trantor.org.uk")
	by vger.kernel.org with ESMTP id S269526AbUICBZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 21:25:22 -0400
Subject: Re: silent semantic changes with reiser4
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040901161456.GA31934@mail.shareable.org>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl>
	 <41352279.7020307@slaphack.com> <20040901045922.GA512@elf.ucw.cz>
	 <20040901161456.GA31934@mail.shareable.org>
Content-Type: text/plain
Date: Fri, 03 Sep 2004 02:25:30 +0100
Message-Id: <1094174730.9282.24.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-01 at 17:14 +0100, Jamie Lokier wrote:
> So all I am asking for is a facility to auto-mount with
> file-as-directory, and the ability for a userspace daemon to be
> notified of regular file modifications synchronously.  Both can be
> added later, once file-as-directory and moveable mounts are
> established.  (fcntl leases and dnotify _almost_ provide this, but
> they don't.  Looks like incoherent hacks keep getting added all over
> the place for Samba... :).

How will synchronous file modification notifications be handled?

Programs listening for the notification will want to see the changes
when they read the file but the reason this is synchronous is to prevent
other applications seeing the changes before they are reflected in these
indexing programs etc.. right?

-- 
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/scaramanga.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

