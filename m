Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280002AbRLWRGS>; Sun, 23 Dec 2001 12:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281835AbRLWRGI>; Sun, 23 Dec 2001 12:06:08 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:37836 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S280002AbRLWRGG>; Sun, 23 Dec 2001 12:06:06 -0500
Date: Sun, 23 Dec 2001 12:06:04 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Chris Vandomelen <chrisv@b0rked.dhs.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Assigning syscall numbers for testing
Message-ID: <20011223120604.B19863@redhat.com>
In-Reply-To: <Pine.LNX.4.31.0112221956280.23282-100000@b0rked.dhs.org> <22263.1009084221@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <22263.1009084221@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Sun, Dec 23, 2001 at 04:10:21PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2001 at 04:10:21PM +1100, Keith Owens wrote:
> I'm glad somebody understands the code :).

There are two directions of binary compatibility: forwads and backwards.  
Your patch breaks forwards compatibility if used outside the main tree.  Try 
to understand this.

		-ben
-- 
Fish.
