Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318952AbSHSRVl>; Mon, 19 Aug 2002 13:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318954AbSHSRVl>; Mon, 19 Aug 2002 13:21:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57872 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318952AbSHSRVl>; Mon, 19 Aug 2002 13:21:41 -0400
Date: Mon, 19 Aug 2002 18:25:42 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: klibc and logging
Message-ID: <20020819182542.D17471@flint.arm.linux.org.uk>
References: <3D58B14A.5080500@zytor.com> <20020819142734.B17471@flint.arm.linux.org.uk> <3D60F9A6.6020304@zytor.com> <20020819175429.C17471@flint.arm.linux.org.uk> <3D61239A.7030405@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D61239A.7030405@zytor.com>; from hpa@zytor.com on Mon, Aug 19, 2002 at 09:58:02AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2002 at 09:58:02AM -0700, H. Peter Anvin wrote:
> Either we can add a "syslog" binary, or you can:
> 
> echo '<3>The dohickey is fscked' > /dev/kmsg

Ok, that's fine for the echo-from-scripts problem.  Now what if I bring
in something like stderr of gzip?  I suppose we need to modify all
programs like gzip, etc to use syslog (maybe making perror() log to
syslog)?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

