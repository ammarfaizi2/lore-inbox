Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289062AbSANV1m>; Mon, 14 Jan 2002 16:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289067AbSANV1c>; Mon, 14 Jan 2002 16:27:32 -0500
Received: from chello212186127068.14.vie.surfer.at ([212.186.127.68]:50848
	"EHLO server.home.at") by vger.kernel.org with ESMTP
	id <S289062AbSANV1T>; Mon, 14 Jan 2002 16:27:19 -0500
Subject: Re: floating point exception
From: Christian Thalinger <e9625286@student.tuwien.ac.at>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201141256300.28735-100000@netfinity.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.33.0201141256300.28735-100000@netfinity.realnet.co.sz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 14 Jan 2002 22:26:26 +0100
Message-Id: <1011043588.645.0.camel@sector17.home.at>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-14 at 11:56, Zwane Mwaikambo wrote:
> >Right after that my window manager segfaults. Ok, switch to console,
> >restart it and go. No! Can't start any programs anymore, no login. All
> >tasks die one after the other, up to the complete lock of the machine.
> >Even alt-sysrq doesn't work.
> 
> Can you reproduce the problem with some degree of success? (2/5 is fine)
> 
> Regards,
> 	Zwane Mwaikambo
> 

After a little bit of testing i would say yes. 2-3 out of 5 with kernel
2.4.17 and 2.4.18-pre3. Mainly with X, got some without X.

It seems the floating point exception is only raised with a new data
package. Is there a simple way to raise such a exception?

