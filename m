Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293626AbSCSD4A>; Mon, 18 Mar 2002 22:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293628AbSCSDzu>; Mon, 18 Mar 2002 22:55:50 -0500
Received: from zok.SGI.COM ([204.94.215.101]:2527 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S293626AbSCSDzi>;
	Mon, 18 Mar 2002 22:55:38 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
Cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Looking to do userless input 'make *config' . 
In-Reply-To: Your message of "Mon, 18 Mar 2002 21:26:00 CDT."
             <Pine.LNX.4.44.0203182055340.275-100000@filesrv1.baby-dragons.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 19 Mar 2002 14:55:23 +1100
Message-ID: <20349.1016510123@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2002 21:26:00 -0500 (EST), 
"Mr. James W. Laferriere" <babydr@baby-dragons.com> wrote:
>	Hello All ,  I have a .config file that has only the needed items
>	defined .  What I am looking to do is have the 'make *config'
>	be in a script that builds a kernel .  I'd like to have all
>	entries that would pop up in a 'make oldconfig' as undefined
>	be defined as 'N' .

yes '' | make oldconfig
takes the default for all questions.

