Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271814AbTHDP4O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 11:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271832AbTHDP4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 11:56:14 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:44481 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S271814AbTHDP4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 11:56:11 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Mon, 4 Aug 2003 17:56:09 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Brian Pawlowski <beepy@netapp.com>
Cc: aebr@win.tue.nl, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-Id: <20030804175609.7301d075.skraw@ithnet.com>
In-Reply-To: <200308041542.h74Fg9k26251@orbit-fe.eng.netapp.com>
References: <20030804134415.GA4454@win.tue.nl>
	<200308041542.h74Fg9k26251@orbit-fe.eng.netapp.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003 08:42:09 -0700 (PDT)
Brian Pawlowski <beepy@netapp.com> wrote:

> I'm still waking up, but '..' obviously breaks the "no cycle"
> observations.

Hear, hear ...

> It's just that '..' is well known name by utilities as opposed
> to arbitrary links.

Well, that leads only to the point that ".." implementation is just lousy and
it should have been done right in the first place. If there is a need for a
loop or a hardlink (like "..") all you have to have is a standard way to find
out, be it flags or the like, whatever. But taking the filename or anything not
applicable to other cases as matching factor was obviously short-sighted.

Regards,
Stephan
