Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268541AbTANDJq>; Mon, 13 Jan 2003 22:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268544AbTANDJq>; Mon, 13 Jan 2003 22:09:46 -0500
Received: from relay04.roc.frontiernet.net ([66.133.131.37]:61092 "EHLO
	relay04.roc.frontiernet.net") by vger.kernel.org with ESMTP
	id <S268541AbTANDJp>; Mon, 13 Jan 2003 22:09:45 -0500
Date: Mon, 13 Jan 2003 22:18:36 -0500
From: Scott McDermott <vaxerdec@frontiernet.net>
To: linux-kernel@vger.kernel.org
Subject: Re: console framebuffer scrolling speed
Message-ID: <20030113221836.B9108@newbox.localdomain>
References: <Pine.A41.4.44.0301102211020.105386-100000@dante51.u.washington.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.A41.4.44.0301102211020.105386-100000@dante51.u.washington.edu>; from mgjohn@u.washington.edu on Fri, Jan 10, 2003 at 10:24:25PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M. Johnson on Fri 10/01 22:24 -0800:
> When using the unaccelerated framebuffer console, the speed of
> scrolling up in programs like less and vi is much, much slower than
> the speed of scrolling down, which makes these programs unusable on
> slower computers.
> 
> Does anyone know why this is, or how easily it can be fixed?

you are using vesafb? turn off ywrap, turn on mtrr
