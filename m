Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272975AbTHKTLt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272956AbTHKTK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 15:10:27 -0400
Received: from bolthole.com ([192.220.72.215]:1543 "HELO bolthole.com")
	by vger.kernel.org with SMTP id S272963AbTHKTJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 15:09:50 -0400
Date: Mon, 11 Aug 2003 12:09:49 -0700
From: Philip Brown <phil@bolthole.com>
To: dri-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Dri-devel] Re: [PATCH] CodingStyle fixes for drm_agpsupport
Message-ID: <20030811120949.A9285@bolthole.com>
Reply-To: Philip Brown <phil@bolthole.com>
Mail-Followup-To: dri-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <E19mF4Y-0005Eg-00@tetrachloride> <20030811164012.GB858@work.bitmover.com> <3F37CB44.5000307@pobox.com> <20030811170425.GA4418@work.bitmover.com> <3F37CF4E.3010605@pobox.com> <20030811172333.GA4879@work.bitmover.com> <3F37D80D.5000703@pobox.com> <20030811175941.GB4879@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030811175941.GB4879@work.bitmover.com>; from lm@bitmover.com on Mon, Aug 11, 2003 at 10:59:41AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 10:59:41AM -0700, Larry McVoy wrote:
>...
> It is inconsistent, on purpose.  It's essentially like perl's
> 
> 	return unless pointer;
> 
> which is a oneliner, almost like an assert().

perl is EEeeeeevil....



> Maybe this will help: I insist on braces on anything with indentation so
> that I can scan them more quickly.  If I gave you a choice between
> 
> 	if (!pointer) {
> 		return (whatever);
> 	}
> 
> 	if (!pointer) return (whatever);
> 
> which one will you type more often?


 if (!pointer) {
	return (whatever);
 }


because it's consistent, and guaranteed safe from stupid parsing errors
that can waste days of debug time when someone decides to add to it.
("its just a little change that cant hurt anything", ha ha)


Style Matters.  (and so do comments, while we're on the subject)
