Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272366AbTHECKZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 22:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272371AbTHECKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 22:10:25 -0400
Received: from pop.gmx.de ([213.165.64.20]:57743 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S272366AbTHECKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 22:10:25 -0400
Message-ID: <3F2F11EA.68E127A8@gmx.de>
Date: Tue, 05 Aug 2003 04:09:46 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: Randolph Bentson <bentson@holmsjoen.com>, jesse@cats-chateau.net,
       aebr@win.tue.nl, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
References: <20030804141548.5060b9db.skraw@ithnet.com>
		<03080409334500.03650@tabby>
		<20030804170506.11426617.skraw@ithnet.com>
		<03080416092800.04444@tabby>
		<20030805003210.2c7f75f6.skraw@ithnet.com>
		<20030804160009.B3751@grieg.holmsjoen.com> <20030805021046.06008535.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:
>
> The setup you describe is exactly the reason why I suggested elsewhere (in a
> private discussion) to single-link all directory entries pointing to the same
> directory in a list. In case of deletion of the "main" entry, the "main" simply
> can walk on to the next (former) hardlink, if there are any left the tree is
> deleted completely. That's it.

Amiga-FFS challenged? ;-)
