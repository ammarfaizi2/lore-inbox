Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272810AbTHEOEj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 10:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272811AbTHEOEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 10:04:39 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:62365 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S272810AbTHEOEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 10:04:37 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 5 Aug 2003 16:04:35 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: root@chaos.analogic.com
Cc: helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-Id: <20030805160435.7b151b0e.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.53.0308050916140.5994@chaos>
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<03080409334500.03650@tabby>
	<20030804170506.11426617.skraw@ithnet.com>
	<03080416092800.04444@tabby>
	<20030805003210.2c7f75f6.skraw@ithnet.com>
	<3F2FA862.2070401@aitel.hist.no>
	<20030805150351.5b81adfe.skraw@ithnet.com>
	<Pine.LNX.4.53.0308050916140.5994@chaos>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 09:36:37 -0400 (EDT)
"Richard B. Johnson" <root@chaos.analogic.com> wrote:

> A hard-link is, by definition, indistinguishable from the original
> entry. In fact, with fast machines and the course granularity of
> file-system times, even the creation time may be exactly the
> same.

Hello Richard,

I really don't mind if you call the thing I am looking for a hardlink or a
chicken. And I am really not sticking to creating them by ln or mount or just
about anything else. I am, too, not bound to making them permanent on the
media. All I really want to do is to _export_ them via nfs.
And guys, looking at mount -bind makes me think someone else (before poor me)
needed just about the same thing.
So, instead of constantly feeding my bad conscience, can some kind soul explain
the possibilities to make "mount -bind/rbind" work over a network fs of some
flavor, please?

Regards,
Stephan

PS: if you ever want to find out what *nix people are carrying guns, just enter
the room and cry out loud "directory hardlinks to the left!"
;-)


