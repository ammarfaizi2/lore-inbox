Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271743AbTHDNpE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 09:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271747AbTHDNpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 09:45:04 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:6329 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S271743AbTHDNo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 09:44:59 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Mon, 4 Aug 2003 15:44:56 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Christian Reichert <c.reichert@resolution.de>
Cc: mru@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-Id: <20030804154456.4ce45410.skraw@ithnet.com>
In-Reply-To: <1060004221.3f2e617d72d4f@corporate.resolution.de>
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<yw1xsmohioah.fsf@users.sourceforge.net>
	<20030804152226.60204b61.skraw@ithnet.com>
	<1060004221.3f2e617d72d4f@corporate.resolution.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Aug 2003 15:37:01 +0200
Christian Reichert <c.reichert@resolution.de> wrote:

> Hi !
> 
> the fundamental problem as i know it is that the FS design in unix is based
> on a directory TREE structure - however if you implement hard links for 
> directories you are breaking this strict treeu structure and can end up with 
> loops/graphs.

This is just the same with softlinks, or not?

> (What are the cases where a symlink wouldn't be enough ?)

fs export via nfs. It only works out if all your symlinked trees are completely
visible to the client, so you have to open big wholes for no good reason at all
...
Just as an example.

Regards,
Stephan

