Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbSLZRvo>; Thu, 26 Dec 2002 12:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263362AbSLZRvo>; Thu, 26 Dec 2002 12:51:44 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:38405 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263321AbSLZRvn>;
	Thu, 26 Dec 2002 12:51:43 -0500
Date: Thu, 26 Dec 2002 09:55:50 -0800
From: Greg KH <greg@kroah.com>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: [PATCH/RFC] New module refcounting for TTY ldisc
Message-ID: <20021226175550.GD8229@kroah.com>
References: <Pine.LNX.4.33.0212251951540.7979-100000@champ.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0212251951540.7979-100000@champ.qualcomm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 25, 2002 at 08:03:02PM -0800, Max Krasnyansky wrote:
> Folks,
> 
> Here is the patch that converts TTY ldisc code to the new 
> module refcounting API.

Nice, does this mean you are going to add module reference counting to
other parts of the tty core?  :)

thanks,

greg k-h
