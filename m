Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280813AbRKOLis>; Thu, 15 Nov 2001 06:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280812AbRKOLij>; Thu, 15 Nov 2001 06:38:39 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:37637 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S280810AbRKOLiX>;
	Thu, 15 Nov 2001 06:38:23 -0500
Date: Thu, 15 Nov 2001 22:35:26 +1100
From: Anton Blanchard <anton@samba.org>
To: "David S. Miller" <davem@redhat.com>
Cc: groudier@free.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] small sym-2 fix
Message-ID: <20011115223526.A27258@krispykreme>
In-Reply-To: <20011115153654.E22552@krispykreme> <20011115.021916.45712781.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011115.021916.45712781.davem@redhat.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Are you using 4K pages on ppc64? :-(

Unfortunately so. We will definitely be looking to decouple hardware and
software page sizes (like sparc64 is doing) once things stabilise, a
4KB page size is pretty small for a 64 bit arch.

Anton
