Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265306AbUBANvS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 08:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265309AbUBANvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 08:51:18 -0500
Received: from doortje.mesa.nl ([80.126.82.97]:26631 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id S265306AbUBANvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 08:51:14 -0500
Date: Sun, 1 Feb 2004 14:51:01 +0100
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: 2.6 input drivers FAQ
Message-ID: <20040201135101.GA25794@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
References: <20040201100644.GA2201@ucw.cz> <20040201141516.A28045@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040201141516.A28045@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries,

On Sun, Feb 01, 2004 at 02:15:16PM +0100, Andries Brouwer wrote:
> On Sun, Feb 01, 2004 at 11:06:44AM +0100, Vojtech Pavlik wrote:
> 
> > Common problems and solutions with 2.6 input drivers:
> 
> Good!
> 
> > Get a recent version of kbd-utils, and recompile on a 2.6 kernel.
> 
> on both 2.4 and 2.6, regardless where they were compiled.

ON Fedora development (around 30 jan)

% rpm -qf /usr/bin/setkeycodes
kbd-1.08-12

% /usr/bin/setkeycodes e001 130
setkeycode: code outside bounds
usage: setkeycode scancode keycode ...
 (where scancode is either xx or e0xx, given in hexadecimal,
  and keycode is given in decimal)

-Marcel
-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
