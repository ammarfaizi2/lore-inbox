Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWCROJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWCROJv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 09:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWCROJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 09:09:51 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:44252 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750855AbWCROJv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 09:09:51 -0500
Date: Sat, 18 Mar 2006 15:09:36 +0100
To: Nick Warne <nick@linicks.net>
Cc: Felipe Alfaro Solana <felipe.alfaro@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: chmod 111
Message-ID: <20060318140936.GA1797@aitel.hist.no>
References: <200603171746.18894.nick@linicks.net> <6f6293f10603171007vbf752e5n8a3d6f2d65e0a1e7@mail.gmail.com> <200603171811.01963.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603171811.01963.nick@linicks.net>
User-Agent: Mutt/1.5.11+cvs20060126
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 06:11:01PM +0000, Nick Warne wrote:
> 
> Yes, I see now after much messing about.  Why then are most binaries chmod 
> 755?  Who would need (why) to read a [system] binary?

The system binaries are normally not considered secret.  (You can
download source for any of them.)  So why prevent anyone from reading them?

Reading the binaries are convenient for copying them, or backing them
up.  This don't happen often, but there is no need to make life difficult
as these files contain no secrets.

Similiarly - lots of files in etc could be made root only.  But
there is no need.  Making more stuff root only also force people to
use root more often, which is a bad thing.

Helge Hafting
