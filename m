Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271041AbTGVXKg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 19:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271042AbTGVXKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 19:10:35 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:12463
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S271041AbTGVXKf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 19:10:35 -0400
Date: Tue, 22 Jul 2003 19:25:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Erik Andersen <andersen@codepoet.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Promise SATA driver GPL'd
Message-ID: <20030722232539.GA18075@gtf.org>
References: <20030722184532.GA2321@codepoet.org> <20030722185443.GB6004@gtf.org> <20030722190705.GA2500@codepoet.org> <20030722205629.GA27179@gtf.org> <20030722213926.GA4295@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722213926.GA4295@codepoet.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 03:39:26PM -0600, Erik Andersen wrote:
> By that I assume you mean osl-1.1 like libata.c, rather than GPL
> like ata_piix.c....

Yep :)


> I expect I may be copying bits and pieces
> from the Promise driver though.  Certainly I'd like to use as
> much of their header files as seems practical.  So it may very
> well need to stay GPL'd.  But I'll see what I can do.

Thanks.  If you are so motivated, I tend to think it can work without
the Promise headers.  For example, there is a distinct naming scheme in
libata, and also intentional use of enums rather than macros as
constants.

However, that said, you're doing the work, so I'll let you make the call :)

	Jeff



