Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288010AbSABXW1>; Wed, 2 Jan 2002 18:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288015AbSABXUV>; Wed, 2 Jan 2002 18:20:21 -0500
Received: from marine.sonic.net ([208.201.224.37]:43048 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S288013AbSABXUJ>;
	Wed, 2 Jan 2002 18:20:09 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Wed, 2 Jan 2002 15:19:55 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: "Eric S. Raymond" <esr@thyrsus.com>, Dave Jones <davej@suse.de>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102231955.GC29462@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	"Eric S. Raymond" <esr@thyrsus.com>, Dave Jones <davej@suse.de>,
	Lionel Bouton <Lionel.Bouton@free.fr>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <3C338DCC.3020707@free.fr> <Pine.LNX.4.33.0201022349200.427-100000@Appserv.suse.de> <20020102174824.A21408@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020102174824.A21408@thyrsus.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 05:48:24PM -0500, Eric S. Raymond wrote:
> But a setuid program *will not solve my problem*.

It does NOT have to be setuid.

su 
echo 'dmidecode > /var/run/dmi' >> /etc/init.d/bootmisc.sh

And reboot once (or run the command by hand).

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
