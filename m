Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbSKHPtv>; Fri, 8 Nov 2002 10:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbSKHPtv>; Fri, 8 Nov 2002 10:49:51 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:2835 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262201AbSKHPtv>;
	Fri, 8 Nov 2002 10:49:51 -0500
Date: Fri, 8 Nov 2002 16:55:37 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: installing modules to ($PREFIX)/lib/modules/2.....
Message-ID: <20021108155537.GA1027@mars.ravnborg.org>
Mail-Followup-To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20021108154132.GC1319@rdlg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021108154132.GC1319@rdlg.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 10:41:32AM -0500, Robert L. Harris wrote:
>   I've compiled my kernel and modules but want to install the modules to
> /tmp/lib/modules/2.4.18 so I can tar that up and move it to the server
> in question.  Is there a system for doing this built into the kernel
> compile structure I haven't found yet?

make INSTALL_PATH=/tmp modules_install
IIRC this is true for 2.4 as well.

	Sam
