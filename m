Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbWHOCIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbWHOCIs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 22:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbWHOCIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 22:08:48 -0400
Received: from smtp105.rog.mail.re2.yahoo.com ([206.190.36.83]:63330 "HELO
	smtp105.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751534AbWHOCIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 22:08:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=e825Pr2lp6pyYBf4NB3gNvmZkzCcxNLZLeaRkKMuH0cOK4ubh3pMVDI5stswbMsMj/jAtZVlQX2UymYEFKEmQ9V+65YUCJAUTeYcqm4yEvBWeZwOEUvRFId7/Ul6T0mqak60FAoP4LfWdihbsvzoXhzudSHhN63G0bimD9NfZgM=  ;
Subject: Re: vga text console
From: James C Georgas <jgeorgas@rogers.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1155606849.3948.17.camel@daplas.org>
References: <1155604313.8131.4.camel@Rainsong>
	 <1155604928.3948.8.camel@daplas.org>  <1155605197.3948.10.camel@daplas.org>
	 <1155606109.8131.13.camel@Rainsong>  <1155606849.3948.17.camel@daplas.org>
Content-Type: text/plain
Date: Mon, 14 Aug 2006 22:09:28 -0400
Message-Id: <1155607768.8131.22.camel@Rainsong>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-15-08 at 09:54 +0800, Antonino A. Daplas wrote:
> > If I define CONFIG_EMBEDDED, is that going to change the behaviour of
> > other subsystems, or does it just enable more options?
> > 
> 
> It basically opens up a lot of config options. It may also disable a few
> incompatible options (ie, CONFIG_DEBUG_VERBOSE), and enable a few.  It
> will require that you know exactly what options need to be turned on or
> off.
Oh. That actually sounds like it could be a lot of fun. I'm a big fan of
the Minimal Kernel.

I'm kind of surprised that the VGA console can't be built as a module,
like the other console drivers in the kernel can be. Is this on purpose,
or is it just that nobody has gotten around to it?

