Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129291AbRA0Crr>; Fri, 26 Jan 2001 21:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129610AbRA0Crg>; Fri, 26 Jan 2001 21:47:36 -0500
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:516 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129291AbRA0Cr3>; Fri, 26 Jan 2001 21:47:29 -0500
Date: Sat, 27 Jan 2001 15:47:15 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Paul Powell <moloch16@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Undoing chroot?
Message-ID: <20010127154714.A313@metastasis.f00f.org>
In-Reply-To: <20010126183140.17534.qmail@web112.yahoomail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010126183140.17534.qmail@web112.yahoomail.com>; from moloch16@yahoo.com on Fri, Jan 26, 2001 at 10:31:40AM -0800
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2001 at 10:31:40AM -0800, Paul Powell wrote:

    So how do you reverse a CHROOT?

move the prison walls inside of your cell then walk away:

as root:

  mkdir("blah");
  chroot("blah");
  chdir("../../../../../../");

sort of thing



  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
