Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269854AbUJMVNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269854AbUJMVNr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 17:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269858AbUJMVNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 17:13:46 -0400
Received: from mx1.magmacom.com ([206.191.0.217]:12718 "EHLO mx1.magmacom.com")
	by vger.kernel.org with ESMTP id S269854AbUJMVNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 17:13:25 -0400
Subject: Re: Gnome-2.8 stoped working on kernel-2.6.9-rc4-mm1
From: Jesse Stockall <stockall@magma.ca>
To: Stef van der Made <svdmade@planet.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <416D923B.3030404@planet.nl>
References: <Pine.LNX.4.58.0410131204580.31327@danga.com>
	 <416D8999.7080102@pobox.com> <Pine.LNX.4.58.0410131302190.31327@danga.com>
	 <416D8C33.9080401@osdl.org>  <416D923B.3030404@planet.nl>
Content-Type: text/plain
Message-Id: <1097702032.5500.115.camel@homer.blizzard.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 13 Oct 2004 17:13:52 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-13 at 16:38, Stef van der Made wrote:
> I'm trying to get kernel-2.6.9-rc4-mm1 to work with gnome-2.8. While 
> 2.6.9-rc4 works fine with gnome-2.8 the mm1 version has an issue. Any 
> process that I'm trying to start that uses gnome libraries crashes 
> immediatly after startup. Mozilla, nautilus and gnome terminal to name a 
> few. The reason for using mm1 is that I'm using reiser4 for one of my 
> partitions.
> 

Hi

I had the same issue,

here's a fix
cd /usr/src/linux-2.6.9-rc4-mm1
wget
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out/optimize-profile-path-slightly.patch
patch -R -p1 < optimize-profile-path-slightly.patch

Jesse

-- 
Jesse Stockall <stockall@magma.ca>

