Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbTHYJmt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 05:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbTHYJmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 05:42:49 -0400
Received: from us01smtp1.synopsys.com ([198.182.44.79]:6817 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S261604AbTHYJmr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 05:42:47 -0400
Date: Mon, 25 Aug 2003 11:42:40 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, Con Kolivas <conman@kolivas.net>
Subject: Re: [PATCH]O18.1int
Message-ID: <20030825094240.GJ16080@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, Con Kolivas <conman@kolivas.net>
References: <200308231555.24530.kernel@kolivas.org> <yw1xr83accpa.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xr83accpa.fsf@users.sourceforge.net>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård, Mon, Aug 25, 2003 11:24:01 +0200:
> XEmacs still spins after running a background job like make or grep.
> It's fine if I reverse patch-O16.2-O16.3. The spinning doesn't happen
> as often, or as long time as with O16.3, but it's there and it's
> irritating.

another example is RXVT (an X terminal emulator). Starts spinnig after
it's child has exited. Not always, but annoyingly often. System is
almost locked while it spins (calling select).

