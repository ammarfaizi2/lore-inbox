Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276215AbRI1R7f>; Fri, 28 Sep 2001 13:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276210AbRI1R7Y>; Fri, 28 Sep 2001 13:59:24 -0400
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:9734 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S276211AbRI1R7J>; Fri, 28 Sep 2001 13:59:09 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: all files are executable in vfat
In-Reply-To: <Pine.GSO.4.21.0109251332470.24321-100000@weyl.math.psu.edu>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 28 Sep 2001 19:58:46 +0200
In-Reply-To: <Pine.GSO.4.21.0109251332470.24321-100000@weyl.math.psu.edu> (Alexander Viro's message of "Tue, 25 Sep 2001 13:33:15 -0400 (EDT)")
Message-ID: <tgr8srrycp.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> writes:

> On Tue, 25 Sep 2001, William Scott Lockwood III wrote:
> 
> > dmask?
> 
> Umm... That makes sense.

I wrote a small patch for that over a year ago, but it wasn't
integrated because it didn't seem necessary because of the noexec
option, and we didn't know about about the mc problem back then.  The
patch was for 2.2.13.  It featured a critical defect, though.

If there's need for it, I can make a version for 2.4.10.

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
