Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132131AbRAHUAV>; Mon, 8 Jan 2001 15:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132265AbRAHUAL>; Mon, 8 Jan 2001 15:00:11 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:11782 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S132131AbRAHT77>; Mon, 8 Jan 2001 14:59:59 -0500
Date: Mon, 8 Jan 2001 20:50:01 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: richbaum@acm.org
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] More compile warning fixes for 2.4.0
Message-ID: <20010108205001.S3472@arthur.ubicom.tudelft.nl>
In-Reply-To: <3A5790E3.18256.963C79@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5790E3.18256.963C79@localhost>; from baumr1@coral.indstate.edu on Sat, Jan 06, 2001 at 09:40:51PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2001 at 09:40:51PM -0500, Rich Baum wrote:
> Here's a patch that fixes more of the compile warnings with gcc 
> 2.97.

> -    case FORE200E_STATE_BLANK:
> +    case FORE200E_STATE_BLANK:;

Is this really a kernel bug? This is common idiom in C, so gcc
shouldn't warn about it. If it does, it is a bug in gcc IMHO.


Erik
(compiling a GCC CVS snapshot to see if it really breaks)

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
