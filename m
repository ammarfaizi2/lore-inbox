Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbTHYKJh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 06:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbTHYKJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 06:09:37 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:16318
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S261644AbTHYKJf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 06:09:35 -0400
From: Con Kolivas <kernel@kolivas.org>
To: alexander.riesen@synopsys.COM,
       =?iso-8859-1?q?M=E5ns=20Rullg=E5rd?= <mru@users.sourceforge.net>
Subject: Re: [PATCH]O18.1int
Date: Mon, 25 Aug 2003 20:16:13 +1000
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200308231555.24530.kernel@kolivas.org> <yw1xr83accpa.fsf@users.sourceforge.net> <20030825094240.GJ16080@Synopsys.COM>
In-Reply-To: <20030825094240.GJ16080@Synopsys.COM>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308252016.13315.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Aug 2003 19:42, Alex Riesen wrote:
> Måns Rullgård, Mon, Aug 25, 2003 11:24:01 +0200:
> > XEmacs still spins after running a background job like make or grep.
> > It's fine if I reverse patch-O16.2-O16.3. The spinning doesn't happen
> > as often, or as long time as with O16.3, but it's there and it's
> > irritating.
>
> another example is RXVT (an X terminal emulator). Starts spinnig after
> it's child has exited. Not always, but annoyingly often. System is
> almost locked while it spins (calling select).

What does vanilla kernel do with these apps running? Both immediately after 
the apps have started up and some time (>1 min) after they've been running?

Con

