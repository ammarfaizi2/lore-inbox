Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264970AbTFWQP2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 12:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264772AbTFWQNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 12:13:22 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:63244 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264927AbTFWQMy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 12:12:54 -0400
Date: Mon, 23 Jun 2003 18:32:34 +0200
To: John Bradford <john@grabjohn.com>
Cc: felipe_alfaro@linuxmail.org, helgehaf@aitel.hist.no,
       linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler & interactivity improvements
Message-ID: <20030623163234.GA1184@hh.idb.hist.no>
References: <200306231244.h5NCiE1Q000920@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306231244.h5NCiE1Q000920@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 01:44:14PM +0100, John Bradford wrote:
> 
> Well, no, opaque window moving is fine if the CPU isn't at 100%.  If
> it is, I'd rather see choppy window movements than have a server
> application starved of CPU.  That's just my preference, though.
> 
That could be an interesting hack to a window manager - 
don't start the move in opaque mode when the load is high.

Helge Hafting
