Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266996AbTB0U2Z>; Thu, 27 Feb 2003 15:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266994AbTB0U2Y>; Thu, 27 Feb 2003 15:28:24 -0500
Received: from pizda.ninka.net ([216.101.162.242]:53391 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266996AbTB0U2M>;
	Thu, 27 Feb 2003 15:28:12 -0500
Date: Thu, 27 Feb 2003 12:21:26 -0800 (PST)
Message-Id: <20030227.122126.30208201.davem@redhat.com>
To: bcollins@debian.org
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
       ak@suse.de, arnd@bergmann-dalldorf.de
Subject: Re: ioctl32 consolidation -- call for testing
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030227203440.GP21100@phunnypharm.org>
References: <20030227202739.GO21100@phunnypharm.org>
	<20030227.121302.86023203.davem@redhat.com>
	<20030227203440.GP21100@phunnypharm.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Collins <bcollins@debian.org>
   Date: Thu, 27 Feb 2003 15:34:40 -0500

   On Thu, Feb 27, 2003 at 12:13:02PM -0800, David S. Miller wrote:
   >    From: Ben Collins <bcollins@debian.org>
   >    Date: Thu, 27 Feb 2003 15:27:39 -0500
   >    
   >    Here it is. Sparc64's macros for ioctl32's assumed that cmd was u_int
   >    instead of u_long. This look ok to you, Dave?
   > 
   > We would love to see that patch :-)
   
   It was real small...so small that it slipped through mutt's open() call
   and never got attached :)

Well, you just doubled the size of the table on sparc64.
I don't know if I like that.
