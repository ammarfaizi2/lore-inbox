Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287148AbSABWxy>; Wed, 2 Jan 2002 17:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287143AbSABWxq>; Wed, 2 Jan 2002 17:53:46 -0500
Received: from marine.sonic.net ([208.201.224.37]:17230 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S287145AbSABWxf>;
	Wed, 2 Jan 2002 17:53:35 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Wed, 2 Jan 2002 14:53:29 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102225329.GB29462@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020102170833.A17655@thyrsus.com> <E16Lu2i-0005nd-00@the-village.bc.nu> <20020102172448.A18153@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020102172448.A18153@thyrsus.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 05:24:48PM -0500, Eric S. Raymond wrote:
> But you're thinking like a developer, not a user.  The right question
> is which approach requires the lowest level of *user* privilege to get
> the job done.  Comparing world-readable /proc files versus a setuid app,
> the answer is obvious.  This sort of thing is exactly what /proc is *for*.

What's wrong with a startup routine that includes something like:

dmidecode > /var/run/dmi

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
