Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261866AbSJVIlj>; Tue, 22 Oct 2002 04:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262291AbSJVIlj>; Tue, 22 Oct 2002 04:41:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40460 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261866AbSJVIli>; Tue, 22 Oct 2002 04:41:38 -0400
Date: Tue, 22 Oct 2002 09:47:43 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44 : move files from drivers/media/* ?
Message-ID: <20021022094743.A16174@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0210212136030.900-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210212136030.900-100000@localhost.localdomain>; from fdavis@si.rr.com on Mon, Oct 21, 2002 at 09:45:29PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 09:45:29PM -0400, Frank Davis wrote:
> Hello all,
>   There are video and radio drivers within
> drivers/media/video and drivers/media/radio respectively.
> 
> Shouldn't those drivers move from drivers/media/video to drivers/video ? 

drivers/video are display drivers.  drivers/media/video are grabber
drivers.  The two are different.

Reasons why drivers/media exists can be found by searching a LKML
archive.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

