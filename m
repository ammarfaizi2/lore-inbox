Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWE2HTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWE2HTu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 03:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWE2HTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 03:19:50 -0400
Received: from styx.suse.cz ([82.119.242.94]:31622 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750726AbWE2HTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 03:19:49 -0400
Date: Mon, 29 May 2006 09:19:14 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: "LKML, " <linux-kernel@vger.kernel.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, Andi Kleen <ak@muc.de>,
       Andrey Panin <pazke@orbita1.ru>
Subject: Re: Should we make dmi_check_system case insensitive?
Message-ID: <20060529071914.GA16787@suse.cz>
References: <200605290131.42292.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605290131.42292.dtor_core@ameritech.net>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2006 at 01:31:41AM -0400, Dmitry Torokhov wrote:
> Hi,
> 
> I have a request to add entry for "LifeBook B Series" to lifebook driver to
> accomodate lifebook B2545, however we already have entry for "LIFEBOOK B
> Series" (used by some other model) which is not working. Would anyone
> be opposed making dmi_check_system() ignore string case? We would have to
> malloc/copy both strings and lowercase them before doing stsstr...   
 
I think it's easier to just add the second entry. We're trying to
distinguish individual machines here, the fact that we have a single DMI
entry accomodating a whole series is an exception.

-- 
Vojtech Pavlik
Director SuSE Labs
