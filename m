Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129363AbRB0NsT>; Tue, 27 Feb 2001 08:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129346AbRB0NsJ>; Tue, 27 Feb 2001 08:48:09 -0500
Received: from janeway.cistron.net ([195.64.65.23]:36876 "EHLO
	janeway.cistron.net") by vger.kernel.org with ESMTP
	id <S129344AbRB0NsA>; Tue, 27 Feb 2001 08:48:00 -0500
Date: Tue, 27 Feb 2001 14:47:46 +0100
From: Ivo Timmermans <irt@cistron.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: binfmt_script and ^M
Message-ID: <20010227144746.B25058@cistron.nl>
In-Reply-To: <20010227140333.C20415@cistron.nl> <E14XkQG-0003R7-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14XkQG-0003R7-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Feb 27, 2001 at 01:44:08PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > When running a script (perl in this case) that has DOS-style newlines
> > (\r\n), Linux 2.4.2 can't find an interpreter because it doesn't
> > recognize the \r.  The following patch should fix this (untested).
> 
> Fix the script. The kernel expects a specific format

For what reason?  Is it a standard to not allow it, or does it break
other things?


-- 
Ivo Timmermans
