Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269538AbTGOT34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 15:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269544AbTGOT34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 15:29:56 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:6806 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S269538AbTGOT3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 15:29:54 -0400
Date: Tue, 15 Jul 2003 20:44:01 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Brian Gerst <bgerst@didntduck.org>,
       Luciano Miguel Ferreira Rocha <luciano@lsd.di.uminho.pt>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Interrupt doesn't make it to the 8259 on a ASUS P4PE mobo
Message-ID: <20030715194401.GA2503@mail.jlokier.co.uk>
References: <PMEMILJKPKGMMELCJCIGOEKNCCAA.kfrazier@mdc-dayton.com> <3F14348B.4050606@didntduck.org> <20030715175909.GA17226@lsd.di.uminho.pt> <3F1446E9.8040409@didntduck.org> <1058294665.3845.61.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058294665.3845.61.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > > Isn't (HZ >> 1) better?
> > 
> > Same thing.  GCC knows that division by a power of 2 is just a shift.
> 
> Only for unsigned

Or when HZ is constant :)

-- J?amie
