Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129074AbQJ3NUy>; Mon, 30 Oct 2000 08:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129165AbQJ3NUp>; Mon, 30 Oct 2000 08:20:45 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:54796 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129074AbQJ3NUf>;
	Mon, 30 Oct 2000 08:20:35 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux_developer@hotmail.com (Linux Kernel Developer),
        linux-kernel@vger.kernel.org
Subject: Re: Need info on the use of certain datastructures and the first C++ keyword patch for 2.2.17 
In-Reply-To: Your message of "Mon, 30 Oct 2000 13:04:06 -0000."
             <E13qEbg-0006rE-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Oct 2000 00:20:29 +1100
Message-ID: <4119.972912029@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000 13:04:06 +0000 (GMT), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>You may find that creating your own wrappers for these files that do
>
>extern "C" {
>#define new new_
>#define private private_
>#include <linux/foo.h>
>#undef new
>#undef private
>}
>
>safer, since you won't break anything

It breaks module symbol versions, see earlier mail to l-k.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
