Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272584AbTHEIFv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 04:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272586AbTHEIFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 04:05:50 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:49643 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S272584AbTHEIFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 04:05:44 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 5 Aug 2003 10:05:42 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Edgar Toernig <froese@gmx.de>
Cc: bentson@holmsjoen.com, jesse@cats-chateau.net, aebr@win.tue.nl,
       linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-Id: <20030805100542.2fd8f386.skraw@ithnet.com>
In-Reply-To: <3F2F11EA.68E127A8@gmx.de>
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<03080409334500.03650@tabby>
	<20030804170506.11426617.skraw@ithnet.com>
	<03080416092800.04444@tabby>
	<20030805003210.2c7f75f6.skraw@ithnet.com>
	<20030804160009.B3751@grieg.holmsjoen.com>
	<20030805021046.06008535.skraw@ithnet.com>
	<3F2F11EA.68E127A8@gmx.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Aug 2003 04:09:46 +0200
Edgar Toernig <froese@gmx.de> wrote:

> Stephan von Krawczynski wrote:
> >
> > The setup you describe is exactly the reason why I suggested elsewhere (in a
> > private discussion) to single-link all directory entries pointing to the same
> > directory in a list. In case of deletion of the "main" entry, the "main" simply
> > can walk on to the next (former) hardlink, if there are any left the tree is
> > deleted completely. That's it.
> 
> Amiga-FFS challenged? ;-)

Ah, he knows the roots ;-)

Regards,
Stephan
