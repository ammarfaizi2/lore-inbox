Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274894AbRIVLjs>; Sat, 22 Sep 2001 07:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273568AbRIVLji>; Sat, 22 Sep 2001 07:39:38 -0400
Received: from u-1-18.karlsruhe.ipdial.viaginterkom.de ([62.180.18.1]:9875
	"EHLO dea.linux-mips.net") by vger.kernel.org with ESMTP
	id <S274894AbRIVLj0>; Sat, 22 Sep 2001 07:39:26 -0400
Date: Sat, 22 Sep 2001 13:12:19 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: "list, linux-kernel" <linux-kernel@vger.kernel.org>,
        linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: Why the net driver for saa9730 is not a module?
Message-ID: <20010922131219.A27982@dea.linux-mips.net>
In-Reply-To: <3BA91980.C829078B@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BA91980.C829078B@eyal.emu.id.au>; from eyal@eyal.emu.id.au on Thu, Sep 20, 2001 at 08:17:36AM +1000
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 08:17:36AM +1000, Eyal Lebedinsky wrote:

> The config does not offer it. Any reason?
> 
> I had no trouble building it, however I do not have the hware to check
> that all is well.

SAA9730 is such an extremly buggy piece of silicon that Phillips stopped
supporting it.  So this driver is used for the Atlas board only which
also has been superseeded by the Malta board; and you shouldn't expect any
future development on this driver.  That said, the driver doesn't work
as a module; a quick look at it shows that at least the module_exit()
functionality isn't supported.

  Ralf
