Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285451AbRLNSfK>; Fri, 14 Dec 2001 13:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285452AbRLNSfA>; Fri, 14 Dec 2001 13:35:00 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:49216 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S285451AbRLNSep>; Fri, 14 Dec 2001 13:34:45 -0500
Date: Fri, 14 Dec 2001 19:32:17 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Andrew Morton <akpm@zip.com.au>, Johan Ekenberg <johan@ekenberg.se>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, jack@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: Lockups with 2.4.14 and 2.4.16
Message-ID: <20011214193217.H2431@athlon.random>
In-Reply-To: <000a01c1829f$75daf7a0$050010ac@FUTURE> <000a01c1829f$75daf7a0$050010ac@FUTURE> <3825380000.1008348567@tiny> <3C1A3652.52B989E4@zip.com.au> <3845670000.1008352380@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3845670000.1008352380@tiny>; from mason@suse.com on Fri, Dec 14, 2001 at 12:53:00PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2001 at 12:53:00PM -0500, Chris Mason wrote:
> I'll try this, and also add kinoded so we can avoid using keventd.  I'm wary

using keventd for that doesn't look too bad to me. Just like we do with
the dirty inode flushing. keventd doesn't do anything 99.9% of the time,
so it sounds a bit wasteful to add yet another daemon that will remain
idle 99% of the time too... :)

Andrea
