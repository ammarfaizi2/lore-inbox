Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbTI1Sug (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 14:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbTI1Sug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 14:50:36 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:39099 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S262700AbTI1SuB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 14:50:01 -0400
Date: Sun, 28 Sep 2003 20:48:41 +0200
From: Axel Siebenwirth <axel@pearbough.net>
To: Malte@neon.pearbough.net, Schroeder@neon.pearbough.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] [2.6.0-test6] Stale NFS file handle
Message-ID: <20030928184841.GL532@neon>
Mail-Followup-To: Malte@arcor-online.net, Schroeder@arcor-online.net,
	linux-kernel@vger.kernel.org
References: <200309282031.54043.MalteSch@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <200309282031.54043.MalteSch@gmx.de>
User-Agent: Mutt/1.4.1i
Organization: pearbough.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Malte!

On Sun, 28 Sep 2003, Malte Schr?der wrote:

> Hi,
> since 2.6.0-test6 I get "Stale NFS file handle" when transferring huge amounts 
> of data from a nfs-server which is running on -test6.
> The client also runs -test6. Transfers from a server running kernel 2.4.22 
> work flawless.
> 
> I use the nfs-kernel-server 1.0.6 on Debian/sid.

Are you using mount options when mounting the NFS volume?
I had this problem when I used rsize=8192 and wsize=8192 as nfs mount
options. Just left them out and everything was fine again.

Axel



____________________________________________________________________________
Axel Siebenwirth				      phone +49 3641 776807 |
Am Birnstiel 3			 		  axel at pearbough dot net |
07745 Jena								    |
Germany________________________________________________http://pearbough.net |

For my birthday I got a humidifier and a de-humidifier...  I put them in
the same room and let them fight it out.
                -- Stephen Wright
____________________________________________________________________________
