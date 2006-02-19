Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWBSUpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWBSUpO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 15:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWBSUpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 15:45:14 -0500
Received: from mail1.kontent.de ([81.88.34.36]:28357 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S1751036AbWBSUpM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 15:45:12 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Sun, 19 Feb 2006 21:44:57 +0100
User-Agent: KMail/1.8
Cc: Alan Stern <stern@rowland.harvard.edu>, psusi@cfl.rr.com, pavel@suse.cz,
       torvalds@osdl.org, mrmacman_g4@mac.com, alon.barlev@gmail.com,
       linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
References: <43F89F55.5070808@cfl.rr.com> <Pine.LNX.4.44L0.0602191142290.9165-100000@netrider.rowland.org> <20060219120221.1d11cee0.akpm@osdl.org>
In-Reply-To: <20060219120221.1d11cee0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602192144.57748.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 19. Februar 2006 21:02 schrieb Andrew Morton:
> For a), the current kernel behaviour is what we want - make the thing
> appear at a new place in the namespace and in the hierarchy.  Then
> userspace can do whatever needs to be done to identify the device, and
> apply some sort of policy decision to the result.

How? If you have a running user space the connection to the open files
is already severed, as any access in that time window must fail.
For the rest we have udev.

	Oliver
