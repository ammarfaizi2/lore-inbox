Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262217AbREQXvV>; Thu, 17 May 2001 19:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262218AbREQXvL>; Thu, 17 May 2001 19:51:11 -0400
Received: from ma-northadams1-47.nad.adelphia.net ([24.51.236.47]:33542 "EHLO
	sparrow.net") by vger.kernel.org with ESMTP id <S262217AbREQXu6>;
	Thu, 17 May 2001 19:50:58 -0400
Date: Thu, 17 May 2001 19:51:10 -0400
From: Eric Buddington <eric@sparrow.nad.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: RE: write() writes too many bytes?
Message-ID: <20010517195110.G2271@sparrow.nad.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies for bothering the list with this cool-sounding but bogus
problem; I only sent it accidentally (I discovered my mistake while
writing the original) and followed with a retraction which I stupidly
sent to the old rutgers address. Wish I had sent the original there,
too.

I was fooled by characters inserted by emacs when I loaded up the file
to look at it. I loaded it as text, then converted to hex. Emacs had
already added some '^'s to denote escape characters, and left them in.
My mistake.

-Eric

> My program write()s 2- and 4- byte chunks or data to a file (for a WAV
> header). When the data being written contains an 0xff byte, it is
> apparently written to disk as 2 bytes: 0x81ff.

----- End forwarded message -----
