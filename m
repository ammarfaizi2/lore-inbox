Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272492AbTHEPIS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 11:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272493AbTHEPIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 11:08:18 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:29091 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S272492AbTHEPIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 11:08:17 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 5 Aug 2003 17:08:14 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: root@chaos.analogic.com
Cc: helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-Id: <20030805170814.04326306.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.53.0308051042310.6347@chaos>
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<03080409334500.03650@tabby>
	<20030804170506.11426617.skraw@ithnet.com>
	<03080416092800.04444@tabby>
	<20030805003210.2c7f75f6.skraw@ithnet.com>
	<3F2FA862.2070401@aitel.hist.no>
	<20030805150351.5b81adfe.skraw@ithnet.com>
	<Pine.LNX.4.53.0308050916140.5994@chaos>
	<20030805160435.7b151b0e.skraw@ithnet.com>
	<Pine.LNX.4.53.0308051042310.6347@chaos>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 10:57:11 -0400 (EDT)
"Richard B. Johnson" <root@chaos.analogic.com> wrote:

> But symlinks work over NFS. You just have to make sure they are
> relative to whatever the remote mount-point is:

Yes, I know this works. But honestly I'd say that this is a very ugly thing.
That's why I want to get rid of it completely (using it currently). The
straight forward method for linking/remounting stuff is following the links (or
whatever) on the fileserver and not on the client (like with symlinks).

Regards,
Stephan
