Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265842AbTL3QfL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 11:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265843AbTL3QfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 11:35:11 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:65028 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265842AbTL3QfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 11:35:06 -0500
Date: Tue, 30 Dec 2003 17:35:03 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0+BK keyboard problems
Message-ID: <20031230163503.GA17107@win.tue.nl>
References: <Pine.GSO.4.44.0312301157210.23594-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0312301157210.23594-100000@math.ut.ee>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 12:04:31PM +0200, Meelis Roos wrote:
> I compiled todays 2.6.0-BK and tried it on my PC with Estonian layout
> PS/2 keyboard (Keytronic KT800PS2ES03). I has one problem with
> loadkeys and some strange messages when X starts.
> 
> The problem comes from loadkeys. Debian startup scrips do
> dumpkeys | sed ... | loadkeys and the loadkeys command fails with the
> following messages:
> KDSKBENT: Invalid argument
> failed to bind key 256 to value 638

In 2.6, NR_KEYS changed. I suppose you want to recompile loadkeys.

