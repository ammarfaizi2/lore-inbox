Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265633AbSLIOUp>; Mon, 9 Dec 2002 09:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265636AbSLIOUp>; Mon, 9 Dec 2002 09:20:45 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:12005 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S265633AbSLIOUo>; Mon, 9 Dec 2002 09:20:44 -0500
Date: Mon, 9 Dec 2002 15:28:15 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE feature request
Message-ID: <20021209142815.GA3097@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
References: <068d01c29d97$f8b92160$551b71c3@krlis> <1039312135.27904.11.camel@irongate.swansea.linux.org.uk> <20021208234102.GA8293@scssoft.com> <at28st$ifd$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <at28st$ifd$1@forge.intermeta.de>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2002 at 02:21:17PM +0000, Henning P. Schmiedehausen wrote:
> >On Sun, Dec 08, 2002 at 01:09:34AM +0000, Alan Cox wrote:
> >> Fix ide.c to generate a b c d e f and you should be able to get 16.
> >Like this?
> 
> you will get the same problem again, once someone is able to cram more than
> 16 IDE hosts into a box. Why not go for ide%d (ide0-9, ide10-99)?

"%x" ? 0 1 2 3 4 5 6 7 8 9 a b c d e f ... 10 11 .. hdeadbeef :)

> If we go to idea - idef now, we will be stuck with that for ages.
