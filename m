Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265700AbTBBWav>; Sun, 2 Feb 2003 17:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265708AbTBBWav>; Sun, 2 Feb 2003 17:30:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41476 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265700AbTBBWau>; Sun, 2 Feb 2003 17:30:50 -0500
Date: Sun, 2 Feb 2003 22:40:18 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: b_adlakha@softhome.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: what all has changed in ppp?
Message-ID: <20030202224018.A5478@flint.arm.linux.org.uk>
Mail-Followup-To: b_adlakha@softhome.net, linux-kernel@vger.kernel.org
References: <courier.3E3D59B9.00006CAD@softhome.net> <20030202185836.B32007@flint.arm.linux.org.uk> <courier.3E3D86F1.00001BF0@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <courier.3E3D86F1.00001BF0@softhome.net>; from b_adlakha@softhome.net on Sun, Feb 02, 2003 at 02:00:33PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 02, 2003 at 02:00:33PM -0700, b_adlakha@softhome.net wrote:
> Oh yes, sorry I forgot, module tty_ldisk3 cannot be found, so ppp dies with 
> exit status 1...
> I didn't think ppp needs anything other than ppp_generic, the serial driver 
> for ppp and the compression modules...
> What is tty_ldisk3? could you help me on this? 

It's the ppp line discipline.  Add to /etc/modules.conf:

alias tty-ldisc-3 ppp_async

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

