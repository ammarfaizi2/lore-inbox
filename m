Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262479AbSKCVcu>; Sun, 3 Nov 2002 16:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262481AbSKCVcu>; Sun, 3 Nov 2002 16:32:50 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12814 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262479AbSKCVct>; Sun, 3 Nov 2002 16:32:49 -0500
Date: Sun, 3 Nov 2002 21:39:20 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5: troubles with piping make output
Message-ID: <20021103213920.H5589@flint.arm.linux.org.uk>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Sam Ravnborg <sam@ravnborg.org>,
	Kai Germaschewski <kai-germaschewski@uiowa.edu>,
	linux-kernel@vger.kernel.org
References: <200211031122.gA3BMbp27805@Port.imtp.ilyichevsk.odessa.ua> <20021103182805.GA1057@mars.ravnborg.org> <200211031946.gA3JkIp29186@Port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.44.0211032106010.6949-100000@serv> <20021103202446.F5589@flint.arm.linux.org.uk> <Pine.LNX.4.44.0211032146240.6949-100000@serv> <20021103212435.G5589@flint.arm.linux.org.uk> <Pine.LNX.4.44.0211032227100.6949-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211032227100.6949-100000@serv>; from zippel@linux-m68k.org on Sun, Nov 03, 2002 at 10:29:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 10:29:38PM +0100, Roman Zippel wrote:
> As I already said, oldconfig still works as before. Maybe you should have 
> tried it first?

I have.  However, I thought you were about to change the oldconfig
behaviour.  My bad.

The patch is still required, though, to make sure stdout is flushed to
the user before asking a question, which doesn't happen in the case I
highlighted.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

